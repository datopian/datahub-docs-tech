# Authorization Set up

Authorization is the process of giving someone permission to do or have something. In multi-user systems, a system administrator defines for the system which users are allowed access to the system and what privileges of use.

We have a standard access control matrix with 3 axes:

- Actions: CREATE, READ, WRITE, DELETE, PURGE etc. these can vary among different entities
- Entities (object): User, Publisher, Package, Package Resource, …
- Users: a user or type of user

Permission is a tuple of ```(Users, Entities, Actions)```

## Introducing Roles

It can be tiresome and inefficient to list for every object all the users permitted to perform a given action. For example:

- Many users in an organization get same set of privileges because of their position in the organization.
- We want to change the permissions associated with a certain level in the organization and to have those permissions changed for all people in that level
- A user may change level frequently (ex. user may get promoted)

So we create roles

* Per object roles e.g. Package Owner
* Per system roles e.g. System Administrator
* A list or algorithm for assigning Users => Roles

Access control algorithm:
```
is_allowed(user, entity, action)
```

For this user: what roles do they have related to this entity and the system?
Given those roles: what actions do they have: UNIONrole

Note: it would get more complex if some roles deny access. E.g. Role: Spammer might mean you are denied action to posting etc. Right now we don’t have that issue.

Is the desired action in that set?

### Roles
The example roles are given below.

- Package
    - Owner  => all actions
    - Editor
        - Read
        - Create
        - Delete
        - Undelete
        - Update
        - Tag
    - Viewer  => Only read
- Publisher
    - Owner => all actions on Publisher
    - Editor
        - ViewMemberList
        - AddMember
        - RemoveMember
        - Read
    - Viewer => Only Read
- System
    - LoggedIn
        - Package::Create
        - Publisher::Create
    - All => Package::Read on public packages
    - Sysadmin => all actions

[This](https://github.com/frictionlessdata/dpr-api/blob/master/app/auth/authorization.py#L11) contains the current roles.

### Business roles

- Publisher Owner
    - Publisher::Owner
- Publisher Member
    - Publisher::Editor
- (Logged in) User
    - System::LoggedIn
- Sys Admin
    - System::Sysadmin
- Visitor
    - System::Anonymous


> NOTE: business roles and authorization roles are distinct. Of course, in implementing access control we will use the business logic inherent in business roles. However, business roles are not explicitly present in the access control system.

## Actions

> Note: not an exhaustive list. [This](https://github.com/frictionlessdata/dpr-api/blob/master/app/auth/authorization.py#L11) contains the current Actions.


- Package:
    - Package::Read
    - Package::Create
    - Package::Delete
    - Package::Undelete
    - Package::Purge
    - Package::Update
    - Package::Tag
- Publisher:
    - Publisher::Create
    - Publisher::AddMember
    - Publisher::RemoveMember
    - Publisher::Read
    - Publisher::Delete
    - Publisher::Update
    - Publisher::ViewMemberList

## Examples
### First time visitor or not logged in:
The business role will be ```System::Anonymous```. So the user can only has the action permission of ```Package::Read```.
So the user can only view the public data packages.

### Logged in user:
The business role will be ```System::LoggedIn``` . So the user will have permission of :

- ```Publisher::Create``` : The user can create new publisher.
- ```Package::Create``` : The user can create new data package.
- ```Package::Read``` : Can read public data packages
