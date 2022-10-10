# SampleService


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



```
Mutation Test


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
