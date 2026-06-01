@Library('jenkins-test-library') _

def configMap = [
    project: "roboshop"
    component: "catalogue"
]

echo "Triggering the Library pipeline"

if (env.BRANCH_NAME.equalIgnoreCase('main')){
    echo "checking later"
}
else{
    testPipeline(configMap)
}