# Alias commad
## 1. Install Alias
```
git clone https://github.com/SoSonoFuriren/alias.git
cd alias
# if your kubernetes and dms tool is install in sudo mode, please choose the aliassu
./install.sh <alias||aliassu>
```
## 2. Command
## 2.1 Kubernetes Relative
- getallns
    - get all namespace
- getallpod
    - get all pod information
- getallsvc
    - get all service information
- getalldpy
    - get all deployment information
- getnspod <namespace>
    - get specific namespace pod information
- getspecpod <pod name key word>
    - get specific pods information
- getspecsvc <svc name key word>
    - get specific service information
- podnsname <namespace or name key words>
    - get specific namespaces and pods
- descpod <specific pod name key word>
    - Describe specific pod
- logpod <specific pod name key word>
    - print pod log
- logpodf <specific pod name key word>
    - stream printing pod log
- delpod <specific pod name key word>
    - delete specific pod

## 2.2 xApp Relative
- getallxapp
    - get all xApp pod
- getallxappchart
    - get all onboarded xApp
- onboardxapp <config file> <Schema file>
    - onboard specific pod
- deployxapp <xApp name> <version> <xApp namespace>
    - deploy specific xApp
- undeployxapp <xApp name> <xApp namespace>
    - undeploy specific xApp
- deletexapp <XAPP_CHART_NAME> <VERSION>
    - delete a specific Chart Version from helm repository
- getrtmtable
    - list routing table
- getnbconn
    - list all e2 connection
- getnbdetail <RAN name>