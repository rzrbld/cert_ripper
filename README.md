## cert ripper
get cert chain from target host, parse it and put each cert to java keystore

### example: 
```
./certripper.sh -k=/home/esb/wso2esb-4.8.1/repository/resources/security/client-truststore.jks -p=wso2carbon -h=example.com:443 -n=example.com
```
### commands:
    -k    or --path-to-keystore  = path to keystore 
    -p    or --keysotre-password = keystore password
    -h    or --host              = target host
    -n    or --name              = alias prefix
    -help or --usage             = help

### quirks 
please note: keytool must be in $PATH variable, if not - you get an error about unknown command, you can fix that by adding path to keytool utility to $PATH variable or make ``` find / -name "keytool" ``` which will give you something like: ``` /usr/lib/jvm/java-7/bin/keytool ``` and replace path to keytool in script on 67 string.
 
### license
The MIT License (MIT) Copyright (c) 2012,2013,2014,2015,2016 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
