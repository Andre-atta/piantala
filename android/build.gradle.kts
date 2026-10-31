allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)

    // Forza la compatibilità Java/Kotlin a 17 per risolvere "Inconsistent JVM Target Compatibility" nei plugin
    tasks.withType<JavaCompile>().configureEach {
        sourceCompatibility = "17"
        targetCompatibility = "17"
    }
    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>().configureEach {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }
}

// Forza compileSdk=36 su tutti i plugin di terze parti (es. isar_flutter_libs)
// che hanno un compileSdk obsoleto hardcodato nel proprio build script.
// DEVE stare PRIMA di evaluationDependsOn per evitare "already evaluated" error.
subprojects {
    if (project.name != "app") {
        project.afterEvaluate {
            val androidExt = extensions.findByName("android")
            if (androidExt != null) {
                try {
                    val getCompileSdkVersion = androidExt.javaClass.getMethod("getCompileSdkVersion")
                    val setCompileSdkVersion = androidExt.javaClass.getMethod("compileSdkVersion", Int::class.java)
                    val current = getCompileSdkVersion.invoke(androidExt)?.toString()
                        ?.removePrefix("android-")?.toIntOrNull() ?: 0
                    if (current < 36) {
                        setCompileSdkVersion.invoke(androidExt, 36)
                    }

                    // Forza Java 17 anche nelle opzioni di compilazione Android del plugin
                    val compileOptions = androidExt.javaClass.getMethod("getCompileOptions").invoke(androidExt)
                    val setSource = compileOptions.javaClass.getMethod("setSourceCompatibility", org.gradle.api.JavaVersion::class.java)
                    val setTarget = compileOptions.javaClass.getMethod("setTargetCompatibility", org.gradle.api.JavaVersion::class.java)
                    setSource.invoke(compileOptions, org.gradle.api.JavaVersion.VERSION_17)
                    setTarget.invoke(compileOptions, org.gradle.api.JavaVersion.VERSION_17)
                } catch (_: Exception) {}
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    val configureNamespace = {
        if (project.hasProperty("android")) {
            val androidExt = project.extensions.findByName("android")
            androidExt?.let { ext ->
                try {
                    val getNamespace = ext.javaClass.getMethod("getNamespace")
                    val setNamespace = ext.javaClass.getMethod("setNamespace", String::class.java)
                    if (getNamespace.invoke(ext) == null) {
                        setNamespace.invoke(ext, project.group.toString())
                    }
                } catch (_: Exception) {}
            }
        }
    }

    // Se il progetto è già stato valutato (es. a causa di evaluationDependsOn),
    // eseguiamo subito la logica, altrimenti ci agganciamo al normale ciclo di vita.
    if (project.state.executed) {
        configureNamespace()
    } else {
        project.afterEvaluate {
            configureNamespace()
        }
    }
}
