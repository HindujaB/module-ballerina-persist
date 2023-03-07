// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for rainier.
// It should not be modified by hand.

import ballerina/time;

public type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    string gender;
    time:Date hireDate;
    string departmentDeptNo;
    string workspaceWorkspaceId;
|};

public type EmployeeInsert Employee;

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    string gender?;
    time:Date hireDate?;
    string departmentDeptNo?;
    string workspaceWorkspaceId?;
|};

public type Workspace record {|
    readonly string workspaceId;
    string workspaceType;
    string locationBuildingCode;
|};

public type WorkspaceInsert Workspace;

public type WorkspaceUpdate record {|
    string workspaceType?;
    string locationBuildingCode?;
|};

public type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
    string 'type;
|};

public type BuildingInsert Building;

public type BuildingUpdate record {|
    string city?;
    string state?;
    string country?;
    string postalCode?;
    string 'type?;
|};

public type Department record {|
    readonly string deptNo;
    string deptName;
|};

public type DepartmentInsert Department;

public type DepartmentUpdate record {|
    string deptName?;
|};

public type OrderItem record {|
    readonly string orderId;
    readonly string itemId;
    int quantity;
    string notes;
|};

public type OrderItemInsert OrderItem;

public type OrderItemUpdate record {|
    int quantity?;
    string notes?;
|};

public type BuildingOptionalized record {|
    readonly string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;
    string 'type?;
|};

public type WorkspaceOptionalized record {|
    readonly string workspaceId?;
    string workspaceType?;
    string locationBuildingCode?;
|};

public type EmployeeOptionalized record {|
    readonly string empNo?;
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    string gender?;
    time:Date hireDate?;
    string departmentDeptNo?;
    string workspaceWorkspaceId?;
|};

public type DepartmentOptionalized record {|
    readonly string deptNo?;
    string deptName?;
|};

public type OrderItemOptionalized record {|
    readonly string orderId?;
    readonly string itemId?;
    int quantity?;
    string notes?;
|};

public type EmployeeWithRelations record {|
    *EmployeeOptionalized;
    DepartmentOptionalized department?;
    WorkspaceOptionalized workspace?;
|};

public type DepartmentWithRelations record {|
    *DepartmentOptionalized;
    EmployeeOptionalized[] employee?;
|};

public type WorkspaceWithRelations record {|
    *WorkspaceOptionalized;
    BuildingOptionalized location?;
    EmployeeOptionalized[] employee?;
|};

public type BuildingWithRelations record {|
    *BuildingOptionalized;
    WorkspaceOptionalized[] workspace?;
|};

public type EmployeeTargetType typedesc<EmployeeWithRelations>;

public type DepartmentTargetType typedesc<DepartmentWithRelations>;

public type WorkspaceTargetType typedesc<WorkspaceWithRelations>;

public type BuildingTargetType typedesc<BuildingWithRelations>;

public type OrderItemTargetType typedesc<OrderItemOptionalized>;
