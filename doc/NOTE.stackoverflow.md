Similar to http://stackoverflow.com/questions/14017364/how-to-create-java-gradle-project?rq=1
suggest to create Android porject with `android create project` than add
<code>build.gradle</code> template for classic Android project <a
href="https://github.com/Nodeclipse/nodeclipse-1/blob/master/org.nodeclipse.enide.editors.gradle/docs/android/build.gradle">gh.c/N/n-1/b/m/o.n.e.e.g/docs/android/build.gradle</a>.
(That would allow to develop in any IDE, as old structure is more widely adopted)

Of course there will be some `gradle init` options or `android create` (from
SDK) in the future.

### UPDATE:

Android SDK 19 has `android` CLI `-g` option that allows to use gradle
template. You might also need to specify android gradle plugin version with
CLI `-v` option, check [android gradle plugin compatibility
table](http://tools.android.com/tech-docs/new-build-system/version-compatibility).
Example command to create the project that uses android gradle plugin (v 0.10)
to add gradle support.

    android create project \
        --gradle \
        --gradle-version 0.10 \
        --activity Main \
        --package com.example.app \
        --target android-19 \
        --path AppWithGradleTemplate

or for buildTools 19.1+, use a newer version of the Gradle Android plugin via
**`--gradle-version`**:

    android create project \
        --gradle \
        --gradle-version 0.11.+ \
        --activity Main \
        --package com.example.app \
        --target android-25 \
        --path AppWithGradleTemplate

check `android create project -h` for help

However Android Studio 0.6.1 failed to open it correctly (no sources shown),
because it took first project folder (that is `gradle`) as module folder ->
you need to Import, not just open.

In Eclipse it was with a trick of regarding `src` folder as root of the
project.

`.classpath` is

    <?xml version="1.0" encoding="UTF-8"?>
    <classpath>
    	<classpathentry kind="src" path="java"/><!--ADJUSTED HERE -->
    	<classpathentry kind="src" path="gen"/>
    	<classpathentry kind="con" path="com.android.ide.eclipse.adt.ANDROID_FRAMEWORK"/>
    	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.LIBRARIES"/>
    	<classpathentry exported="true" kind="con" path="com.android.ide.eclipse.adt.DEPENDENCIES"/>
    	<classpathentry kind="output" path="bin/classes"/>
    </classpath>


And `build.gradle`


    buildscript {
        repositories {
            mavenCentral()
        }
        dependencies {
            classpath 'com.android.tools.build:gradle:0.10.+'
        }
    }
    apply plugin: 'android'

    android {
       //{ for Android Gradle as Eclipse project
        sourceSets {
            main {
                manifest.srcFile 'AndroidManifest.xml'
                java.srcDirs = ['java']
                resources.srcDirs = ['java']
                aidl.srcDirs = ['java']
                renderscript.srcDirs = ['java']
                res.srcDirs = ['res']
                assets.srcDirs = ['assets']
            }

            // Move the tests to tests/java, tests/res, etc...
            androidTest.setRoot('../tests')

            // Move the build types to build-types/<type>
            // For instance, build-types/debug/java, build-types/debug/AndroidManifest.xml, ...
            // This moves them out of them default location under src/<type>/... which would
            // conflict with src/ being used by the main source set.
            // Adding new build types or product flavors should be accompanied
            // by a similar customization.
            debug.setRoot('build-types/debug')
            release.setRoot('build-types/release')
        }
    	//}
        compileSdkVersion 'Google Inc.:Google APIs:10'
        buildToolsVersion '19.0.3'

        buildTypes {
            release {
                runProguard false
                proguardFile getDefaultProguardFile('proguard-android.txt')
            }
        }
        lintOptions {
            abortOnError false
        }
    }

