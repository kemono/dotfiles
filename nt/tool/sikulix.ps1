# make tmp directory
Remove-Item -path C:\tools\SikuliX -recurse -force
New-Item C:\tools\SikuliX -Force -ItemType Directory
Set-Location C:\tools\SikuliX

# file download
Invoke-WebRequest -UseBasicParsing -Uri https://launchpad.net/sikuli/sikulix/2.0.4/+download/sikulixide-2.0.4.jar -OutFile sikulixide-2.0.4.jar
Invoke-WebRequest -UseBasicParsing -Uri https://repo1.maven.org/maven2/org/python/jython-standalone/2.7.1/jython-standalone-2.7.1.jar -OutFile jython-standalone-2.7.1.jar
Invoke-WebRequest -UseBasicParsing -Uri https://repo1.maven.org/maven2/org/jruby/jruby-complete/9.2.0.0/jruby-complete-9.2.0.0.jar -OutFile jruby-complete-9.2.0.0.jar
Invoke-WebRequest -UseBasicParsing -Uri https://launchpad.net/sikuli/sikulix/2.0.4/+download/sikulixapi-2.0.4.jar -OutFile sikulixapi-2.0.4.jar
Invoke-WebRequest -UseBasicParsing -Uri https://repo1.maven.org/maven2/com/sikulix/sikulixapi/2.0.4/sikulixapi-2.0.4-sources.jar -OutFile sikulixapi-2.0.4-sources.jar