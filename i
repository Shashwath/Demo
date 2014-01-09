[1mdiff --git a/LoginJsf/build/web/testing.xhtml b/LoginJsf/build/web/testing.xhtml[m
[1mindex fe41fd6..93a9dc0 100644[m
[1m--- a/LoginJsf/build/web/testing.xhtml[m
[1m+++ b/LoginJsf/build/web/testing.xhtml[m
[36m@@ -26,7 +26,7 @@[m
                   <p:message for="login_password"  display="icon"/>  [m
                     [m
                     <p:commandButton id="login_login" action="" resetValues="false" update="login_gridpanel1" value="" ></p:commandButton>[m
[31m-                  <p:commandButton id="login_reset" action="" value="Reset" >[m
[32m+[m[32m                  <p:commandButton id="login_reset" action="" value="Reset button" >[m
                         <p:ajax resetValues="true" update="login_form" /> [m
                   </p:commandButton>[m
                    [m
[1mdiff --git a/LoginJsf/nbproject/build-impl.xml b/LoginJsf/nbproject/build-impl.xml[m
[1mindex dc7cadc..ec1dc90 100644[m
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
[31m-                    <jvmarg line="${end