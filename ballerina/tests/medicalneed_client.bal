// Copyright (c) 2022 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/sql;
import ballerinax/mysql;
import ballerina/time;

public client class MedicalNeedClient {
    *AbstractPersistClient;

    private final string entityName = "MedicalNeed";
    private final sql:ParameterizedQuery tableName = `MedicalNeeds`;

    private final map<FieldMetadata> fieldMetadata = {
        needId: {columnName: "needId", 'type: int, autoGenerated: true},
        itemId: {columnName: "itemId", 'type: int},
        beneficiaryId: {columnName: "beneficiaryId", 'type: int},
        period: {columnName: "period", 'type: time:Civil},
        urgency: {columnName: "urgency", 'type: string},
        quantity: {columnName: "quantity", 'type: int}
    };
    private string[] keyFields = ["needId"];

    private SQLClient persistClient;

    public function init() returns Error? {
        mysql:Client|sql:Error dbClient = new (host = host, user = user, password = password, database = database, port = port);
        if dbClient is sql:Error {
            return <Error>error(dbClient.message());
        }

        self.persistClient = check new (dbClient, self.entityName, self.tableName, self.keyFields, self.fieldMetadata);
    }

    remote function create(MedicalNeed value) returns MedicalNeed|Error {
        sql:ExecutionResult result = check self.persistClient.runInsertQuery(value);

        return <MedicalNeed>{
            needId: <int>result.lastInsertId,
            beneficiaryId: value.beneficiaryId,
            itemId: value.itemId,
            period: value.period,
            quantity: value.quantity,
            urgency: value.urgency
        };
    }

    remote function readByKey(int key) returns MedicalNeed|Error {
        return <MedicalNeed>check self.persistClient.runReadByKeyQuery(MedicalNeed, key);
    }

    remote function read() returns stream<MedicalNeed, Error?> {
        stream<anydata, sql:Error?>|Error result = self.persistClient.runReadQuery(MedicalNeed);
        if result is Error {
            return new stream<MedicalNeed, Error?>(new MedicalNeedStream((), result));
        } else {
            return new stream<MedicalNeed, Error?>(new MedicalNeedStream(result));
        }
    }

    remote function execute(sql:ParameterizedQuery filterClause) returns stream<MedicalNeed, Error?> {
        stream<anydata, sql:Error?>|Error result = self.persistClient.runExecuteQuery(filterClause, MedicalNeed);
        if result is Error {
            return new stream<MedicalNeed, Error?>(new MedicalNeedStream((), result));
        } else {
            return new stream<MedicalNeed, Error?>(new MedicalNeedStream(result));
        }
    }

    remote function update(MedicalNeed 'object) returns Error? {
        _ = check self.persistClient.runUpdateQuery('object);
    }

    remote function delete(MedicalNeed 'object) returns Error? {
        _ = check self.persistClient.runDeleteQuery('object);
    }

    public function close() returns Error? {
        return self.persistClient.close();
    }

}

public class MedicalNeedStream {
    private stream<anydata, sql:Error?>? anydataStream;
    private Error? err;

    public isolated function init(stream<anydata, sql:Error?>? anydataStream, Error? err = ()) {
        self.anydataStream = anydataStream;
        self.err = err;
    }

    public isolated function next() returns record {|MedicalNeed value;|}|Error? {
        if self.err is error {
            return <Error>self.err;
        } else if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            var streamValue = anydataStream.next();
            if streamValue is () {
                return streamValue;
            } else if (streamValue is sql:Error) {
                return <Error>error(streamValue.message());
            } else {
                record {|MedicalNeed value;|} nextRecord = {value: <MedicalNeed>streamValue.value};
                return nextRecord;
            }
        } else {
            // Unreachable code
            return ();
        }
    }

    public isolated function close() returns Error? {
        if self.anydataStream is stream<anydata, sql:Error?> {
            var anydataStream = <stream<anydata, sql:Error?>>self.anydataStream;
            sql:Error? e = anydataStream.close();
            if e is sql:Error {
                return <Error>error(e.message());
            }
        }
    }
}
