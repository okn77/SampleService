# SampleService


sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10259/tcp
sudo ufw allow 10257/tcp



# Talisman  Not able to catch pass.txt :)  It checks before commiting the code

Talisman is a tool that installs a hook to your repository to ensure that potential secrets or sensitive information do not leave the developer's workstation.

Installation to a single project


# Download the talisman binary

curl https://thoughtworks.github.io/talisman/install.sh > ~/install-talisman.sh

chmod +x ~/install-talisman.sh


# Install to a single project (as pre-push hook)

cd my-git-project

~/install-talisman.sh






## PIT Mutation Testing

It is an open-source fault-finding software testing tool for Java that introduces bugs into the code on purpose and then checks if the test suite can find them or not. PIT is created by Henry Coles, a software developer based in Edinburgh, but has benefited from contributions from numerous others




Mutation Test


Sample Method:
```
public boolean isPositive(int number) {

        boolean result = false;
        if (number >= 0) {
            result = true;
        }
        return result;
        
    }
```
1st mutation
```

public boolean isPositive(int number) {

        boolean result = false;
		// mutator - changed conditional boundary
        if (number > 0) {
            result = true;
        }
        return result;
        
    }

```
2nd mutation
```
public boolean isPositive(int number) {

        boolean result = false;
		// mutator - negated conditional
        if (false) {
            result = true;
        }
        return result;
        
    }
    
```

3rd mutation
```
public boolean isPositive(int number) {

        boolean result = false;
        if (number > 0) {
            result = true;
        }
		
		// mutator - (x == 0 ? 1 : 0)
        return !result;
        
    }
    
```

 A Good unit test should fail (kill) all the mutations #1,#2,#3.
``` 
 @Test
    public void testPositive() {

        CalculatorService obj = new CalculatorService();
        assertEquals(true, obj.isPositive(10));

    }
 
 ```
  
 The above unit test will kill the mutation #2 and #3 (unit test is failed), but the mutation #1 is survived (unit test is passed).
Review the mutation #1 again. To fail (kill) this test (mutation), we should test the conditional boundary, the number zero.

```

@Test
    public void testPositive() {

        CalculatorService obj = new CalculatorService();
        assertEquals(true, obj.isPositive(10));
		//kill mutation #1
        assertEquals(true, obj.isPositive(0));

    }
```

Done, 100% mutation coverage now.

```

   stage('Mutation Test - PIT') {
       steps {
         sh "mvn org.pitest:pitest-maven:mutationCoverage"
       }
          post {
       always {
               pitmutation mutationStatsFile: '**/target/pit-reports/**/mutations.xml'
       }
     }
       
     } 
     
     
pom.xml     
 
 
 
 <plugin>
                <groupId>org.pitest</groupId>
                <artifactId>pitest-maven</artifactId>
                <version>1.5.0</version>
                <dependencies>
                    <dependency>
                        <groupId>org.pitest</groupId>
                        <artifactId>pitest-junit5-plugin</artifactId>
                        <version>0.12</version>
                    </dependency>
                </dependencies>
                <configuration>
                    <mutationThreshold>20</mutationThreshold>
                    <outputFormats>
                        <outputFormat>XML</outputFormat>
                        <outputFormat>HTML</outputFormat>
                    </outputFormats>

                    <targetClasses>
                        <param>com.example.students.controller.*</param>
                    </targetClasses>
                    <targetTests>
                        <param>com.example.students.controller.*</param>
                    </targetTests>

                </configuration>
            </plugin> 
```




## OWASP Dependency-Check 

Dependency-Check is a utility that identifies project dependencies and checks if there are any known, publicly disclosed, vulnerabilities. This tool can be part of the solution to the OWASP Top 10 2017: A9 - Using Components with Known Vulnerabilities. This plug-in can independently execute a Dependency-Check analysis and visualize results.

```





 stage('Vulnerability Scan') {
       steps {
         		sh "mvn dependency-check:check"
       }
       
        post {
       always {
            dependencyCheckPublisher pattern: 'target/dependency-check-report.xml'
       }  
     }
   	 }
   
   
   Pom.xml
   
   
        <plugin>
                <groupId>org.owasp</groupId>
                <artifactId>dependency-check-maven</artifactId>
                <version>6.1.6</version>
                <configuration>
                    <format>ALL</format>
                    <failBuildOnCVSS>20</failBuildOnCVSS
       </configuration>
            </plugin>

   
   
   ```


We can also refactor jenkins pipeline post method.



## Trivy Scan

It is a simple and comprehensive vulnerability scanner for containers and other artifacts. A software vulnerability is a glitch, flaw, or weakness present in the software or in an Operating System.

__CVE__:Common Vulnerabilities and Exposures

The tool can be used like sonarqube. It is useful as it tells about vulnerability and how to fix it.

   ```
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.32.1 image openjdk

   ```

Blue Ocean plugin is used to monitor parallel running builds.





## Kubesec

Kubesec is an open-source Kubernetes security scanner and analysis tool. The way it works, it accepts a single Kubernetes manifests file and provides a severity score for each found vulnerability.   https://kubesec.io/
With Docker image , or curl

   ```
 curl -sSX POST --data-binary @"students.yaml" https://v2.kubesec.io/scan
   ```




## OWASP-ZAP

OWASP ZAP is an open-source web application security scanner. It is intended to be used by both those new to application security as well as professional penetration testers. It is one of the most active Open Web Application Security Project projects and has been given Flagship status.

https://springdoc.org/
//Worker node sudo ufw allow 31932/tcp
curl  192.168.0.11:31932/MySpringBootWeb/hello  



For slack messages with groovy place sendNotification.groovy inside vars folder.


##  DAST
SAST Static  application Security Testing SonarQube 
DAST Dynamic application Security Testing. Tests are done when the application is running. It attacks app from outside and checks misconfigured configurations.


##  CIS Benchmarks  
Center for Internet Security best practice security recommendations.kube-bench is a go application  that  checks whether kubernetes is deployed securely.

__Kube-Bench__: An Open Source Tool for Running Kubernetes CIS Benchmark Tests

https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md#download-and-install-binaries

With the docker image:
 docker run --rm -v `pwd`:/host docker.io/aquasec/kube-bench:latest install
 or
 
wget https://github.com/aquasecurity/kube-bench/releases/download/v0.6.5/kube-bench_0.6.5_linux_amd64.tar.gz
 
tar -xvf kube-bench_0.6.5_linux_amd64.tar.gz


./kube-bench --config-dir cfg --config cfg/config.yaml

sudo ./kube-bench run --config-dir cfg --config cfg/config.yaml  --targets etcd  --version 1.15 --check 2.2 --json | jq .Totals.total_fail


sudo ./kube-bench --config-dir cfg --config cfg/config.yaml master  --version 1.15 --check 4.2.1,4.2.2 --json | jq .[].total_fail


etcd user creation: 
chown etcd:etcd /var/lib/etcd
useradd etcd





Sample request for Istio

while true; do curl -s http://192.168.0.11:31932//MySpringBootWeb/students; sleep 1;done


##  FALCO
Falco is an  open source runtime security project for cloud. It detects unexpected application behavior threates and alerts at
runtime.It is based on rules which trigger alerts. A shell script running or executing a docker image file with kubectl exec command it detects and alerts us default
FalcosideKick UI we can see the visualized alerts.


Extend Falco outputs with falcosidekick

https://falco.org/docs/getting-started/installation/

https://falco.org/blog/extend-falco-outputs-with-falcosidekick/

Join notifications by Slack




https://github.com/octarinesec

https://github.com/octarinesec/kube-scan

 
 
 
 
 
 
With blueocean plugin we can write scripts and get the failde stage name with the help of groovy

```
/////// ******************************* Code for fectching Failed Stage Name ******************************* ///////
import io.jenkins.blueocean.rest.impl.pipeline.PipelineNodeGraphVisitor
import io.jenkins.blueocean.rest.impl.pipeline.FlowNodeWrapper
import org.jenkinsci.plugins.workflow.support.steps.build.RunWrapper
import org.jenkinsci.plugins.workflow.actions.ErrorAction

// Get information about all stages, including the failure cases
// Returns a list of maps: [[id, failedStageName, result, errors]]
@NonCPS
List<Map> getStageResults( RunWrapper build ) {

    // Get all pipeline nodes that represent stages
    def visitor = new PipelineNodeGraphVisitor( build.rawBuild )
    def stages = visitor.pipelineNodes.findAll{ it.type == FlowNodeWrapper.NodeType.STAGE }

    return stages.collect{ stage ->

        // Get all the errors from the stage
        def errorActions = stage.getPipelineActions( ErrorAction )
        def errors = errorActions?.collect{ it.error }.unique()

        return [ 
            id: stage.id, 
            failedStageName: stage.displayName, 
            result: "${stage.status.result}",
            errors: errors
        ]
    }
}

// Get information of all failed stages
@NonCPS
List<Map> getFailedStages( RunWrapper build ) {
    return getStageResults( build ).findAll{ it.result == 'FAILURE' }
}

/////// ******************************* Code for fectching Failed Stage Name ******************************* ///////

pipeline {
....
......

 ```
 
##  HashiCorp Vault 
Kubernetes secrets are base64 format.Encyrpt etcd data is the first way of securing data.
HashiCorp Vault: is another way. Vault is a tool for securely accessing secrets
git clone --branch v0.16.0 https://github.com/hashicorp/vault-helm.git
There are 5 keys at least 3 of them come together for constructing master key and for decrypting the encyrption key.
Keyshare=5 1 Master Key and 1 Encryption key

 ```
 helm repo add hashicorp https://helm.releases.hashicorp.com
 
 helm search repo hashicorp/vault
 
helm install vault --set='ui.enabled=true' ./vault-helm

helm install vault --set='ui.enabled=true' ./vault-helm  --set='ui.serviceType=NodePort' --set='server.dataStorage.enabled=false'
 
 kubectl exec -it vault-0 -- /bin/sh
vault operator init
Unseal Key 1: FnPgm3tsCYfYIGnOWsj5sKIRsiXiMGfAVuEllJbqJOin
Unseal Key 2: gZvoViwmfW1Q40Y7my/pbnDLMQk6hRdKpvhFC0F6deVo
Unseal Key 3: xAieZhyBZiomsVUQ+N8cbSuCOIFpNkHulkl7Q822GbuU
Unseal Key 4: R8Lhmwza5VPTPVf9EjaeMOTZ+zfQ3GI0oCRKtPzDzt2c
Unseal Key 5: 0d4/CjMXN+eUxfr3NeEn+NJJa3a9BvF+sWELP+eXBZgH

Initial Root Token: s.kncOkJzgMBVDWumi57xrPs04

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 3 keys to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.



vault operator unseal FnPgm3tsCYfYIGnOWsj5sKIRsiXiMGfAVuEllJbqJOin
vault operator unseal gZvoViwmfW1Q40Y7my/pbnDLMQk6hRdKpvhFC0F6deVo
vault operator unseal xAieZhyBZiomsVUQ+N8cbSuCOIFpNkHulkl7Q822GbuU


//use Initial Root Token and then exit

vault login s.kncOkJzgMBVDWumi57xrPs04
 
```
Creating Vault secrets

```  
kubectl exec -it vault-0 -- /bin/sh
vault secrets enable -path=crds kv-v2
vault kv get crds/postgresql
vault kv put crds/postgresql username=myadmin password=123 mykey=hellothere  
vault kv metadata get crds/postgresql
```  

Vault-Authorization

```  
cat <<EOF > /home/vault/myapp-policy.hcl
path "crds/data/postgresql" {
capabilities = ["create", "update"]
}
path "crds/data/postgresql" {
capabilities = ["read"]
}
EOF


kubectl exec -it vault-0 -- /bin/sh
vault policy write app /home/vault/myapp-policy.hcl

vault policy list
vault policy read app

export VAULT_TOKEN="$(vault token create -field token -policy=app)"
echo $VAULT_TOKEN
vault kv put crds/postgresql username=hello


```  

Vault-Authentication


```  
kubectl exec -it vault-0 -- /bin/sh
vault login s.kncOkJzgMBVDWumi57xrPs04
vault auth enable kubernetes

vault write auth/kubernetes/config \
token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt




vault write auth/kubernetes/role/javaapp \
bound_service_account_names=app \
bound_service_account_namespaces=demo \
policies=app \
ttl=1h

exit


kubectl describe clusterrolebinding vault-server-binding

```  
Getting vault data from kubernetes :
```  
//Nodejs
npm install --save node-vault-client

const VaultClient = require('node-vault-client');

const vaultClient = VaultClient.boot('main', {
    api: { url: 'https://vault.example.com:8200/' },
    auth: { 
        type: 'appRole', // or 'token', 'iam'
        config: { role_id: '637c065f-c644-5e12-d3d1-e9fa4363af61' } 
    },
});

vaultClient.read('secret/tst').then(v => {
    console.log(v);
}).catch(e => console.error(e));


//php

$username   = file_get_contents("/vault/secrets/username");
$pass   = file_get_contents("/vault/secrets/pass");


```  




