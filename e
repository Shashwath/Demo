[1mdiff --git a/LoginJsf/build/web/index.xhtml b/LoginJsf/build/web/index.xhtml[m
[1mindex 40dc500..56ce5f3 100644[m
[1m--- a/LoginJsf/build/web/index.xhtml[m
[1m+++ b/LoginJsf/build/web/index.xhtml[m
[36m@@ -9,7 +9,7 @@[m
           <f:facet name="first">[m
             <meta http-equiv="X-UA-Compatible" content="EmulateIE8" />[m
             <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>[m
[31m-            <title>PrimeFaces - ShowCase</title>[m
[32m+[m[32m            <title>Triya Solutions</title>[m
         </f:facet>[m
         <f:facet name="last">[m
                 <link type="text/css" rel="stylesheet" href="#{request.contextPath}/css/styles.css" />[m
[1mdiff --git a/LoginJsf/nbproject/build-impl.xml b/LoginJsf/nbproject/build-impl.xml[m
[1mindex dc7cadc..165fa05 100644[m
[1m--- a/LoginJsf/nbproject/build-impl.xml[m
[1m+++ b/LoginJsf/nbproject/build-impl.xml[m
[36m@@ -11,9 +11,9 @@[m
         - execution[m
         - debugging[m
         - javadoc[m
[31m-        - junit compilation[m
[31m-        - junit execution[m
[31m-        - junit debugging[m
[32m+[m[32m        - test compilation[m
[32m+[m[32m        - test execution[m
[32m+[m[32m        - test debugging[m
         - cleanup[m
 [m
         -->[m
[36m@@ -187,6 +187,27 @@[m
             </and>[m
         </condition>[m
         <property name="javac.fork" value="${jdkBug6558476}"/>[m
[32m+[m[32m        <condition property="junit.available">[m
[32m+[m[32m            <or>[m
[32m+[m[32m                <available classname="org.junit.Test" classpath="${run.test.classpath}"/>[m
[32m+[m[32m                <available classname="junit.framework.Test" classpath="${run.test.classpath}"/>[m
[32m+[m[32m            </or>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m        <condition property="testng.available">[m
[32m+[m[32m            <available classname="org.testng.annotations.Test" classpath="${run.test.classpath}"/>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m        <condition property="junit+testng.available">[m
[32m+[m[32m            <and>[m
[32m+[m[32m                <istrue value="${junit.available}"/>[m
[32m+[m[32m                <istrue value="${testng.available}"/>[m
[32m+[m[32m            </and>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m        <condition else="testng" property="testng.mode" value="mixed">[m
[32m+[m[32m            <istrue value="${junit+testng.available}"/>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m        <condition else="" property="testng.debug.mode" value="-mixed">[m
[32m+[m[32m            <istrue value="${junit+testng.available}"/>[m
[32m+[m[32m        </condition>[m
     </target>[m
     <target depends="init" name="-init-cos" unless="deploy.on.save">[m
         <condition property="deploy.on.save" value="true">[m
[36m@@ -345,34 +366,319 @@[m [mor ant -Dj2ee.platform.classpath=&lt;server_classpath&gt; (where no properties f[m
             </sequential>[m
         </macrodef>[m
     </target>[m
[31m-    <target name="-init-macrodef-junit">[m
[32m+[m[32m    <target if="${junit.available}" name="-init-macrodef-junit-init">[m
[32m+[m[32m        <condition else="false" property="nb.junit.batch" value="true">[m
[32m+[m[32m            <and>[m
[32m+[m[32m                <istrue value="${junit.available}"/>[m
[32m+[m[32m                <not>[m
[32m+[m[32m                    <isset property="test.method"/>[m
[32m+[m[32m                </not>[m
[32m+[m[32m            </and>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m        <condition else="false" property="nb.junit.single" value="true">[m
[32m+[m[32m            <and>[m
[32m+[m[32m                <istrue value="${junit.available}"/>[m
[32m+[m[32m                <isset property="test.method"/>[m
[32m+[m[32m            </and>[m
[32m+[m[32m        </condition>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target name="-init-test-properties">[m
[32m+[m[32m        <property name="test.binaryincludes" value="&lt;nothing&gt;"/>[m
[32m+[m[32m        <property name="test.binarytestincludes" value=""/>[m
[32m+[m[32m        <property name="test.binaryexcludes" value=""/>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target if="${nb.junit.single}" name="-init-macrodef-junit-single" unless="${nb.junit.batch}">[m
         <macrodef name="junit" uri="http://www.netbeans.org/ns/web-project/2">[m
             <attribute default="${includes}" name="includes"/>[m
             <attribute default="${excludes}" name="excludes"/>[m
             <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element name="customize" optional="true"/>[m
             <sequential>[m
                 <junit dir="${basedir}" errorproperty="tests.failed" failureproperty="tests.failed" fork="true" showoutput="true" tempdir="${java.io.tmpdir}">[m
[32m+[m[32m                    <test methods="@{testmethods}" name="@{testincludes}" todir="${build.test.results.dir}"/>[m
[32m+[m[32m                    <syspropertyset>[m
[32m+[m[32m                        <propertyref prefix="test-sys-prop."/>[m
[32m+[m[32m                        <mapper from="test-sys-prop.*" to="*" type="glob"/>[m
[32m+[m[32m                    </syspropertyset>[m
[32m+[m[32m                    <formatter type="brief" usefile="false"/>[m
[32m+[m[32m                    <formatter type="xml"/>[m
[32m+[m[32m                    <jvmarg value="-ea"/>[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </junit>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-test-properties" if="${nb.junit.batch}" name="-init-macrodef-junit-batch" unless="${nb.junit.single}">[m
[32m+[m[32m        <macrodef name="junit" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <property name="run.jvmargs.ide" value=""/>[m
[32m+[m[32m                <junit dir="${basedir}" errorproperty="tests.failed" failureproperty="tests.failed" fork="true" showoutput="true" tempdir="${build.dir}">[m
                     <batchtest todir="${build.test.results.dir}">[m
                         <fileset dir="${test.src.dir}" excludes="@{excludes},${excludes}" includes="@{includes}">[m
                             <filename name="@{testincludes}"/>[m
                         </fileset>[m
[32m+[m[32m                        <fileset dir="${build.test.classes.dir}" excludes="@{excludes},${excludes},${test.binaryexcludes}" includes="${test.binaryincludes}">[m
[32m+[m[32m                            <filename name="${test.binarytestincludes}"/>[m
[32m+[m[32m                        </fileset>[m
                     </batchtest>[m
[31m-                    <classpath>[m
[31m-                        <path path="${run.test.classpath}:${j2ee.platform.classpath}:${j2ee.platform.embeddableejb.classpath}"/>[m
[31m-                    </classpath>[m
                     <syspropertyset>[m
                         <propertyref prefix="test-sys-prop."/>[m
                         <mapper from="test-sys-prop.*" to="*" type="glob"/>[m
                     </syspropertyset>[m
                     <formatter type="brief" usefile="false"/>[m
                     <formatter type="xml"/>[m
[31m-                    <jvmarg line="${endorsed.classpath.cmd.line.arg}"/>[m
                     <jvmarg value="-ea"/>[m
[31m-                    <jvmarg line="${runmain.jvmargs}"/>[m
[32m+[m[32m                    <jvmarg line="${run.jvmargs.ide}"/>[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </junit>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-junit-init,-init-macrodef-junit-single, -init-macrodef-junit-batch" if="${junit.available}" name="-init-macrodef-junit"/>[m
[32m+[m[32m    <target if="${testng.available}" name="-init-macrodef-testng">[m
[32m+[m[32m        <macrodef name="testng" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <condition else="" property="testng.methods.arg" value="@{testincludes}.@{testmethods}">[m
[32m+[m[32m                    <isset property="test.method"/>[m
[32m+[m[32m                </condition>[m
[32m+[m[32m                <union id="test.set">[m
[32m+[m[32m                    <fileset dir="${test.src.dir}" excludes="@{excludes},**/*.xml,${excludes}" includes="@{includes}">[m
[32m+[m[32m                        <filename name="@{testincludes}"/>[m
[32m+[m[32m                    </fileset>[m
[32m+[m[32m                </union>[m
[32m+[m[32m                <taskdef classname="org.testng.TestNGAntTask" classpath="${run.test.classpath}" name="testng"/>[m
[32m+[m[32m                <testng classfilesetref="test.set" failureProperty="tests.failed" methods="${testng.methods.arg}" mode="${testng.mode}" outputdir="${build.test.results.dir}" suitename="LoginJsf" testname="TestNG tests" workingDir="${basedir}">[m
[32m+[m[32m                    <xmlfileset dir="${build.test.classes.dir}" includes="@{testincludes}"/>[m
[32m+[m[32m                    <propertyset>[m
[32m+[m[32m                        <propertyref prefix="test-sys-prop."/>[m
[32m+[m[32m                        <mapper from="test-sys-prop.*" to="*" type="glob"/>[m
[32m+[m[32m                    </propertyset>[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </testng>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target name="-init-macrodef-test-impl">[m
[32m+[m[32m        <macrodef name="test-impl" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element implicit="true" name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <echo>No tests executed.</echo>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-junit" if="${junit.available}" name="-init-macrodef-junit-impl">[m
[32m+[m[32m        <macrodef name="test-impl" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element implicit="true" name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:junit excludes="@{excludes}" includes="@{includes}" testincludes="@{testincludes}" testmethods="@{testmethods}">[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </webproject2:junit>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-testng" if="${testng.available}" name="-init-macrodef-testng-impl">[m
[32m+[m[32m        <macrodef name="test-impl" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element implicit="true" name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:testng excludes="@{excludes}" includes="@{includes}" testincludes="@{testincludes}" testmethods="@{testmethods}">[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </webproject2:testng>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-test-impl,-init-macrodef-junit-impl,-init-macrodef-testng-impl" name="-init-macrodef-test">[m
[32m+[m[32m        <macrodef name="test" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:test-impl excludes="@{excludes}" includes="@{includes}" testincludes="@{testincludes}" testmethods="@{testmethods}">[m
[32m+[m[32m                    <customize>[m
[32m+[m[32m                        <classpath>[m
[32m+[m[32m                            <path path="${run.test.classpath}:${j2ee.platform.classpath}:${j2ee.platform.embeddableejb.classpath}"/>[m
[32m+[m[32m                        </classpath>[m
[32m+[m[32m                        <jvmarg line="${endorsed.classpath.cmd.line.arg}"/>[m
[32m+[m[32m                        <jvmarg line="${runmain.jvmargs}"/>[m
[32m+[m[32m                    </customize>[m
[32m+[m[32m                </webproject2:test-impl>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target if="${junit.available}" name="-init-macrodef-junit-debug" unless="${nb.junit.batch}">[m
[32m+[m[32m        <macrodef name="junit-debug" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <junit dir="${basedir}" errorproperty="tests.failed" failureproperty="tests.failed" fork="true" showoutput="true" tempdir="${java.io.tmpdir}">[m
[32m+[m[32m                    <test methods="@{testmethods}" name="@{testincludes}" todir="${build.test.results.dir}"/>[m
[32m+[m[32m                    <syspropertyset>[m
[32m+[m[32m                        <propertyref prefix="test-sys-prop."/>[m
[32m+[m[32m                        <mapper from="test-sys-prop.*" to="*" type="glob"/>[m
[32m+[m[32m                    </syspropertyset>[m
[32m+[m[32m                    <formatter type="brief" usefile="false"/>[m
[32m+[m[32m                    <formatter type="xml"/>[m
[32m+[m[32m                    <jvmarg value="-ea"/>[m
[32m+[m[32m                    <jvmarg line="${debug-args-line}"/>[m
[32m+[m[32m                    <jvmarg value="-Xrunjdwp:transport=${debug-transport},address=${jpda.address}"/>[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </junit>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-test-properties" if="${nb.junit.batch}" name="-init-macrodef-junit-debug-batch">[m
[32m+[m[32m        <macrodef name="junit-debug" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <property name="run.jvmargs.ide" value=""/>[m
[32m+[m[32m                <junit dir="${basedir}" errorproperty="tests.failed" failureproperty="tests.failed" fork="true" showoutput="true" tempdir="${build.dir}">[m
[32m+[m[32m                    <batchtest todir="${build.test.results.dir}">[m
[32m+[m[32m                        <fileset dir="${test.src.dir}" excludes="@{excludes},${excludes}" includes="@{includes}">[m
[32m+[m[32m                            <filename name="@{testincludes}"/>[m
[32m+[m[32m                        </fileset>[m
[32m+[m[32m                        <fileset dir="${build.test.classes.dir}" excludes="@{excludes},${excludes},${test.binaryexcludes}" includes="${test.binaryincludes}">[m
[32m+[m[32m                            <filename name="${test.binarytestincludes}"/>[m
[32m+[m[32m                        </fileset>[m
[32m+[m[32m                    </batchtest>[m
[32m+[m[32m                    <syspropertyset>[m
[32m+[m[32m                        <propertyref prefix="test-sys-prop."/>[m
[32m+[m[32m                        <mapper from="test-sys-prop.*" to="*" type="glob"/>[m
[32m+[m[32m                    </syspropertyset>[m
[32m+[m[32m                    <formatter type="brief" usefile="false"/>[m
[32m+[m[32m                    <formatter type="xml"/>[m
[32m+[m[32m                    <jvmarg value="-ea"/>[m
[32m+[m[32m                    <jvmarg line="${run.jvmargs.ide}"/>[m
[32m+[m[32m                    <jvmarg line="${debug-args-line}"/>[m
[32m+[m[32m                    <jvmarg value="-Xrunjdwp:transport=${debug-transport},address=${jpda.address}"/>[m
[32m+[m[32m                    <customize/>[m
                 </junit>[m
             </sequential>[m
         </macrodef>[m
     </target>[m
[32m+[m[32m    <target depends="-init-macrodef-junit-debug,-init-macrodef-junit-debug-batch" if="${junit.available}" name="-init-macrodef-junit-debug-impl">[m
[32m+[m[32m        <macrodef name="test-debug-impl" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <element implicit="true" name="customize" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:junit-debug excludes="@{excludes}" includes="@{includes}" testincludes="@{testincludes}" testmethods="@{testmethods}">[m
[32m+[m[32m                    <customize/>[m
[32m+[m[32m                </webproject2:junit-debug>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target if="${testng.available}" name="-init-macrodef-testng-debug">[m
[32m+[m[32m        <macrodef name="testng-debug" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${main.class}" name="testClass"/>[m
[32m+[m[32m            <attribute default="" name="testMethod"/>[m
[32m+[m[32m            <element name="customize2" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <condition else="-testclass @{testClass}" property="test.class.or.method" value="-methods @{testClass}.@{testMethod}">[m
[32m+[m[32m                    <isset property="test.method"/>[m
[32m+[m[32m                </condition>[m
[32m+[m[32m                <condition else="-suitename LoginJsf -testname @{testClass} ${test.class.or.method}" property="testng.cmd.args" value="@{testClass}">[m
[32m+[m[32m                    <matches pattern=".*\.xml" string="@{testClass}"/>[m
[32m+[m[32m                </condition>[m
[32m+[m[32m                <delete dir="${build.test.results.dir}" quiet="true"/>[m
[32m+[m[32m                <mkdir dir="${build.test.results.dir}"/>[m
[32m+[m[32m                <webproject1:debug args="${testng.cmd.args}" classname="org.testng.TestNG" classpath="${debug.test.classpath}:${j2ee.platform.embeddableejb.classpath}">[m
[32m+[m[32m                    <customize>[m
[32m+[m[32m                        <customize2/>[m
[32m+[m[32m                        <jvmarg value="-ea"/>[m
[32m+[m[32m                        <arg line="${testng.debug.mode}"/>[m
[32m+[m[32m                        <arg line="-d ${build.test.results.dir}"/>[m
[32m+[m[32m                        <arg line="-listener org.testng.reporters.VerboseReporter"/>[m
[32m+[m[32m                    </customize>[m
[32m+[m[32m                </webproject1:debug>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-testng-debug" if="${testng.available}" name="-init-macrodef-testng-debug-impl">[m
[32m+[m[32m        <macrodef name="testng-debug-impl" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${main.class}" name="testClass"/>[m
[32m+[m[32m            <attribute default="" name="testMethod"/>[m
[32m+[m[32m            <element implicit="true" name="customize2" optional="true"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:testng-debug testClass="@{testClass}" testMethod="@{testMethod}">[m
[32m+[m[32m                    <customize2/>[m
[32m+[m[32m                </webproject2:testng-debug>[m
[32m+[m[32m            </sequential>[m
[32m+[m[32m        </macrodef>[m
[32m+[m[32m    </target>[m
[32m+[m[32m    <target depends="-init-macrodef-junit-debug-impl" if="${junit.available}" name="-init-macrodef-test-debug-junit">[m
[32m+[m[32m        <macrodef name="test-debug" uri="http://www.netbeans.org/ns/web-project/2">[m
[32m+[m[32m            <attribute default="${includes}" name="includes"/>[m
[32m+[m[32m            <attribute default="${excludes}" name="excludes"/>[m
[32m+[m[32m            <attribute default="**" name="testincludes"/>[m
[32m+[m[32m            <attribute default="" name="testmethods"/>[m
[32m+[m[32m            <attribute default="${main.class}" name="testClass"/>[m
[32m+[m[32m            <attribute default="" name="testMethod"/>[m
[32m+[m[32m            <sequential>[m
[32m+[m[32m                <webproject2:test-debug-impl excludes="@{excludes}" includes="@{includes}" testincludes="@{testincludes}" testmethods="@{testmethods}">[m
[32m+[m[32m                    <customize>[m
[32m+[m[32m                        <classpath>[m
[32m+[m[32m                            <path path="${run.test.classpath}:${j2ee.platform.classpath}:${j2ee.platf