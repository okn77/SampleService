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






__PIT Mutation Testing__ is an open-source fault-finding software testing tool for Java that introduces bugs into the code on purpose and then checks if the test suite can find them or not. PIT is created by Henry Coles, a software developer based in Edinburgh, but has benefited from contributions from numerous others



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




