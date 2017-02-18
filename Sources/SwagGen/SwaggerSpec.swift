//
//  SwaggerSpec.swift
//  SwagGen
//
//  Created by Yonas Kolb on 3/12/2016.
//  Copyright © 2016 Yonas Kolb. All rights reserved.
//

import Foundation
import JSONUtilities
import Yams
import PathKit

public class SwaggerSpec: JSONObjectConvertible, CustomStringConvertible {

    public let paths: [String: Endpoint]
    public let definitions: [String: Definition]
    public let parameters: [String: Parameter]
    public let security: [String: Security]
    public let info: Info?
    public let host: String?
    public let basePath: String?
    public let schemes: [String]
    public var enums: [Value] = []

    public struct Info: JSONObjectConvertible {

        public let title: String?
        public let version: String?
        public let description: String?

        public init(jsonDictionary: JSONDictionary) throws {
            title = jsonDictionary.json(atKeyPath: "title")
            version = jsonDictionary.json(atKeyPath: "version")
            description = jsonDictionary.json(atKeyPath: "description")
        }
    }

    public convenience init(path: String) throws {
        var url = URL(string: path)!
        if url.scheme == nil {
            url = URL(fileURLWithPath: path)
        }
        else {
            writeMessage("Loading spec from \(path)")
        }

        let data = try Data(contentsOf: url)
        let string = String(data: data, encoding: .utf8)!
        let yaml = try Yams.load(yaml: string)
        let json = yaml as! JSONDictionary

        try self.init(jsonDictionary: json)
    }

    required public init(jsonDictionary: JSONDictionary) throws {
        info = jsonDictionary.json(atKeyPath: "info")
        host = jsonDictionary.json(atKeyPath: "host")
        basePath = jsonDictionary.json(atKeyPath: "basePath")
        schemes = jsonDictionary.json(atKeyPath: "schemes") ?? []

        var paths: [String: Endpoint] = [:]
        if let pathsDictionary = jsonDictionary["paths"] as? [String: JSONDictionary] {

            for (path, endpointDictionary) in pathsDictionary {
                paths[path] = try Endpoint(path: path, jsonDictionary: endpointDictionary)
            }
        }
        self.paths = paths
        definitions = jsonDictionary.json(atKeyPath: "definitions") ?? [:]
        parameters = jsonDictionary.json(atKeyPath: "parameters") ?? [:]
        security = jsonDictionary.json(atKeyPath: "securityDefinitions") ?? [:]

        resolve()
    }

    func resolve() {
        for (name, security) in security {
            security.name = name
        }

        for (name, parameter) in parameters {
            parameter.isGlobal = true
            parameter.globalName = name
            if parameter.enumValues != nil {
                enums.append(parameter)
            }
            else if let arrayEnum = parameter.arrayValue, arrayEnum.enumValues != nil {
                arrayEnum.isGlobal = true
                arrayEnum.globalName = name
                enums.append(arrayEnum)
            }
        }

        for (name, definition) in definitions {
            definition.name = name

            if let reference = getDefinitionReference(definition.reference) {
                for property in reference.properties {
                    definition.propertiesByName[property.name] = property
                }
            }

            if let reference = getDefinitionReference(definition.parentReference) {
                definition.parent = reference
            }

            for property in definition.properties {
                if let reference = getDefinitionReference(property.reference) {
                    property.object = reference
                }
                if let reference = getDefinitionReference(property.arrayRef) {
                    property.arrayDefinition = reference
                }
                if let reference = getDefinitionReference(property.dictionaryDefinitionRef) {
                    property.dictionaryDefinition = reference
                }

                for enumValue in enums {
                    let propertyEnumValues = property.enumValues ?? property.arrayValue?.enumValues ?? []
                    let globalEnumValues = enumValue.enumValues ?? enumValue.arrayValue?.enumValues ?? []
                    if !propertyEnumValues.isEmpty && propertyEnumValues == globalEnumValues {
                        property.isGlobal = true
                        property.globalName = enumValue.globalName ?? enumValue.name
                        continue
                    }
                }
            }
        }

        for operation in operations {

            for (index, parameter) in operation.parameters.enumerated() {
                if let reference = getDefinitionReference(parameter.reference) {
                    parameter.object = reference
                }
                if let reference = getParameterReference(parameter.reference) {
                    operation.parameters[index] = reference
                }
                if let reference = getDefinitionReference(parameter.arrayRef) {
                    parameter.arrayDefinition = reference
                }
            }
            for response in operation.responses {
                if let reference = getDefinitionReference(response.schema?.reference) {
                    response.schema?.object = reference
                } else if let reference = getDefinitionReference(response.schema?.arrayRef) {
                    response.schema?.arrayDefinition = reference
                }
                if let reference = getDefinitionReference(response.schema?.dictionaryDefinitionRef) {
                    response.schema?.dictionaryDefinition = reference
                }
            }
        }
    }

    func getDefinitionReference(_ reference: String?) -> Definition? {
        return reference?.components(separatedBy: "/").last.flatMap { definitions[$0] }
    }

    func getParameterReference(_ reference: String?) -> Parameter? {
        return reference?.components(separatedBy: "/").last.flatMap { parameters[$0] }
    }

    public var operations: [Operation] {
        return paths.values.reduce([]) { return $0 + $1.operations }
    }

    public var tags: [String] {
        return Array(Set(operations.reduce([]) { $0 + $1.tags })).sorted { $0.compare($1) == .orderedAscending }
    }

    public var opererationsByTag: [String: [Operation]] {
        var dictionary: [String: [Operation]] = [:]

        for tag in tags {
            dictionary[tag] = operations.filter { $0.tags.contains(tag) }
        }
        return dictionary
    }

    public var description: String {
        let ops = "Operations:\n\t" + operations.map { $0.operationId }.joined(separator: "\n\t") as String
        let defs = "Definitions:\n" + Array(definitions.values).map { $0.deepDescription(prefix: "\t") }.joined(separator: "\n") as String
        return "\(info)\n\n\(ops)\n\n\(defs))"
    }
}

public class Endpoint {

    let path: String
    let methods: [String: Operation]

    required public init(path: String, jsonDictionary: JSONDictionary) throws {
        self.path = path

        var methods: [String: Operation] = [:]
        for method in jsonDictionary.keys {
            if method != "security", let dictionary = jsonDictionary[method] as? JSONDictionary {
                let operation = try Operation(path: path, method: method, jsonDictionary: dictionary)
                methods[method] = operation
            }
        }
        self.methods = methods
    }

    var operations: [Operation] { return Array(methods.values) }
}

public class Operation {

    let operationId: String
    let description: String?
    let tags: [String]
    var parameters: [Parameter]
    let method: String
    let path: String
    let responses: [Response]
    var security: [OperationSecurity]

    init(path: String, method: String, jsonDictionary: JSONDictionary) throws {
        self.method = method
        self.path = path
        operationId = try jsonDictionary.json(atKeyPath: "operationId")
        description = jsonDictionary.json(atKeyPath: "description")
        tags = jsonDictionary.json(atKeyPath: "tags") ?? []
        parameters = jsonDictionary.json(atKeyPath: "parameters") ?? []
        security = jsonDictionary.json(atKeyPath: "security") ?? []
        let responseDictionary: JSONDictionary = try jsonDictionary.json(atKeyPath: "responses")
        var responses: [Response] = []
        for (key, value) in responseDictionary {
            if let statusCode = Int(key), let jsonDictionary = value as? JSONDictionary {
                responses.append(Response(statusCode: statusCode, jsonDictionary: jsonDictionary))
            }
        }
        self.responses = responses
    }

    func getParameters(type: Parameter.ParamaterType) -> [Parameter] {
        return parameters.filter { $0.parameterType == type }
    }

    var enums: [Parameter] {
        return parameters.filter { $0.enumValues != nil || $0.arrayValue?.enumValues != nil }
    }
}

public class Response {

    let statusCode: Int
    let description: String?
    var schema: Value?

    init(statusCode: Int, jsonDictionary: JSONDictionary) {
        self.statusCode = statusCode
        description = jsonDictionary.json(atKeyPath: "description")
        schema = jsonDictionary.json(atKeyPath: "schema")
    }
}

public class Definition: JSONObjectConvertible {

    var name: String = ""
    let type: String?
    let description: String?
    let reference: String?
    var parentReference: String?
    var parent: Definition?
    var propertiesByName: [String: Property]
    let requiredProperties: [Property]
    let optionalProperties: [Property]
    let properties: [Property]

    required public init(jsonDictionary: JSONDictionary) throws {

        var json = jsonDictionary
        if let allOf = json.json(atKeyPath: "allOf") as [JSONDictionary]? {
            parentReference = allOf[0].json(atKeyPath: "$ref")
            json = allOf[1]
        }
        type = json.json(atKeyPath: "type")
        reference = json.json(atKeyPath: "$ref")
        description = json.json(atKeyPath: "description")
        propertiesByName = json.json(atKeyPath: "properties") ?? [:]
        propertiesByName.forEach { name, property in
            property.name = name
        }

        var requiredProperties: [Property] = []
        if let required = json.json(atKeyPath: "required") as [String]? {
            for propertyName in required {
                if let property = propertiesByName[propertyName] {
                    property.required = true
                    requiredProperties.append(property)
                }
            }
        }
        self.requiredProperties = requiredProperties
        optionalProperties = Array(propertiesByName.values).filter { !$0.required }.sorted{$0.name < $1.name}
        properties = requiredProperties + optionalProperties
    }

    var allProperties: [Property] {
        return (parent?.allProperties ?? []) + properties
    }

    func deepDescription(prefix: String) -> String {
        return "\(prefix)\(name)\n\(prefix)\(properties.map { $0.deepDescription(prefix: prefix) }.joined(separator: "\n\(prefix)"))"
    }

    var enums: [Value] {
        return properties.filter { $0.enumValues != nil || $0.arrayValue?.enumValues != nil }
    }
}

public class Value: JSONObjectConvertible {

    var name: String
    let description: String?
    var required: Bool
    var type: String
    var reference: String?
    var format: String?
    var enumValues: [String]?
    var arrayValue: Value?
    var arrayDefinition: Definition?
    var arrayRef: String?
    var object: Definition?
    var dictionaryDefinition: Definition?
    var dictionaryDefinitionRef: String?
    var dictionaryValue: Value?
    var collectionFormat: String?
    var collectionFormatSeperator: String? {
        guard let collectionFormat = collectionFormat?.lowercased() else { return nil }
        switch collectionFormat {
        case "csv": return ","
        case "ssv": return " "
        case "tsv": return "\t"
        case "pipes": return "|"
        default: return nil
        }
    }
    var isGlobal = false
    var globalName: String?

    required public init(jsonDictionary: JSONDictionary) throws {
        name = jsonDictionary.json(atKeyPath: "name") ?? ""
        description = jsonDictionary.json(atKeyPath: "description")
        reference = jsonDictionary.json(atKeyPath: "$ref")

        arrayRef = jsonDictionary.json(atKeyPath: "items.$ref")
        arrayValue = jsonDictionary.json(atKeyPath: "items")
        collectionFormat = jsonDictionary.json(atKeyPath: "collectionFormat")

        dictionaryDefinitionRef = jsonDictionary.json(atKeyPath: "additionalProperties.$ref")
        dictionaryValue = jsonDictionary.json(atKeyPath: "additionalProperties")

        required = jsonDictionary.json(atKeyPath: "required") ?? false
        type = jsonDictionary.json(atKeyPath: "type") ?? "unknown"
        format = jsonDictionary.json(atKeyPath: "format")
        enumValues = jsonDictionary.json(atKeyPath: "enum")
        if let schemaRef = jsonDictionary.json(atKeyPath: "schema.$ref") as String? {
            reference = schemaRef
        }

        if let ref = jsonDictionary.json(atKeyPath: "schema.items.$ref") as String? {
            arrayRef = ref
            if let type = jsonDictionary.json(atKeyPath: "schema.type") as String? {
                self.type = type
            }
        }
    }

    func deepDescription(prefix: String) -> String {
        return "\(prefix)\(name): \(type)"
    }
}

public class Parameter: Value {

    var parameterType: ParamaterType?

    enum ParamaterType: String {
        case body
        case path
        case query
        case form
    }

    required public init(jsonDictionary: JSONDictionary) throws {
        parameterType = (try? jsonDictionary.json(atKeyPath: "in") as String).flatMap { ParamaterType(rawValue: $0) }
        try super.init(jsonDictionary: jsonDictionary)
    }
}

public class Property: Value {
}

public class Security: JSONObjectConvertible {

    var name: String = ""
    var type: String
    let scopes: [String]?
    var description: String?

    required public init(jsonDictionary: JSONDictionary) throws {
        type = try jsonDictionary.json(atKeyPath: "type")
        description = jsonDictionary.json(atKeyPath: "description")
        scopes = jsonDictionary.json(atKeyPath: "scopes")
    }

    func deepDescription(prefix: String) -> String {
        return "\(prefix)\(name): \(type)"
    }
}

struct OperationSecurity: JSONObjectConvertible {
    let name: String
    let scopes: [String]

    init(jsonDictionary: JSONDictionary) throws {
        name = jsonDictionary.keys.first ?? ""
        scopes = try jsonDictionary.json(atKeyPath: "\(name).scopes")
    }
}
