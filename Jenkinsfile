// pipeline {
//     agent any

//     environment {
//         RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"  // Replace with your actual Render Service ID
//     }

//     stages {
//         stage('Clone Repository') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio.git'
//             }
//         }

//         stage('Install Dependencies') {
//             steps {
//                 script {
//                     if (fileExists('package.json')) {
//                         sh 'npm install'
//                     } else {
//                         echo 'No package.json found, skipping dependencies installation.'
//                     }
//                 }
//             }
//         }

//         stage('Build App') {
//             steps {
//                 script {
//                     if (fileExists('package.json')) {
//                         sh 'npm run build'
//                     } else {
//                         echo 'No build step required for static site.'
//                     }
//                 }
//             }
//         }

//         stage('Deploy to Render') {
//             steps {
//                 script {
//                     sh '''
//                     curl -X POST "https://api.render.com/deploy/srv-${RENDER_SERVICE_ID}?key=rnd_qXmPDBgzdjGTrvsQRnZcqoz8Z22k"
//                     '''
//                 }
//             }
//         }
//     }
// }



// pipeline {
//     agent any

//     environment {
//         RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg" // Your hardcoded Render service ID
//     }

//     stages {
//         stage('Clone Repository') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio/'
//             }
//         }

//         stage('Install Dependencies') {
//             steps {
//                 script {
//                     if (fileExists('package.json')) {
//                         sh 'npm install'
//                     } else {
//                         echo "No package.json found, skipping dependency installation."
//                     }
//                 }
//             }
//         }

//         stage('Build Website') {
//             steps {
//                 script {
//                     if (fileExists('package.json')) {
//                         sh 'npm run build'
//                     } else {
//                         echo "No build step required for static HTML site."
//                     }
//                 }
//             }
//         }

//         stage('Deploy to Render') {
//             steps {
//                 script {
//                     sh """
//                     curl -X POST -H "Accept: application/json" \
//                     -H "Authorization: Bearer YOUR_RENDER_API_KEY" \
//                     https://api.render.com/v1/services/$RENDER_SERVICE_ID/deploys
//                     """
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             script {
//                 try {
//                     def jsonData = [
//                         pipelineName: env.JOB_NAME,
//                         buildNumber: env.BUILD_NUMBER,
//                         githubRepo: env.GIT_URL ?: "Unknown",
//                         commitHash: env.GIT_COMMIT ?: "Unknown",
//                         executionTime: new Date().format("yyyy-MM-dd HH:mm:ss"),
//                         status: currentBuild.currentResult
//                     ]

//                     def jsonContent = groovy.json.JsonOutput.toJson(jsonData)
//                     writeFile file: "pipeline_build_info.json", text: jsonContent
//                     echo "✅ Pipeline Build Info JSON Created: ${jsonContent}"

//                 } catch (Exception e) {
//                     echo "⚠️ Error writing JSON file: ${e}"
//                 }
//             }
//         }

//         success {
//             echo "✅ Pipeline completed successfully!"
//         }

//         failure {
//             echo "❌ Pipeline failed!"
//         }
//     }
// }



// pipeline {
//     agent any

//     environment {
//         RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg" // Hardcoded Render Service ID
//         RENDER_API_KEY = "rnd_qXmPDBgzdjGTrvsQRnZcqoz8Z22k" // Replace with actual key
//     }

//     stages {
//         stage('Initialize') {
//             steps {
//                 script {
//                     def stageData = [:] // Now inside script block
//                     echo "✅ Pipeline initialized"
//                 }
//             }
//         }

//         stage('Clone Repository') {
//             steps {
//                 script {
//                     startTime = System.currentTimeMillis()
//                     git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio.git'
//                 }
//             }
//             post {
//                 always {
//                     script {
//                         def duration = (System.currentTimeMillis() - startTime) / 1000
//                         stageData['Clone Repository'] = [
//                             status: currentBuild.result ?: "SUCCESS",
//                             duration: "${duration}s"
//                         ]
//                     }
//                 }
//             }
//         }

//         stage('Install Dependencies') {
//             steps {
//                 script {
//                     startTime = System.currentTimeMillis()
//                     if (fileExists('package.json')) {
//                         sh 'npm install'
//                     } else {
//                         echo "No package.json found, skipping dependencies."
//                     }
//                 }
//             }
//             post {
//                 always {
//                     script {
//                         def duration = (System.currentTimeMillis() - startTime) / 1000
//                         stageData['Install Dependencies'] = [
//                             status: currentBuild.result ?: "SUCCESS",
//                             duration: "${duration}s"
//                         ]
//                     }
//                 }
//             }
//         }

//         stage('Build Website') {
//             steps {
//                 script {
//                     startTime = System.currentTimeMillis()
//                     if (fileExists('package.json')) {
//                         sh 'npm run build'
//                     } else {
//                         echo "No build step required for static site."
//                     }
//                 }
//             }
//             post {
//                 always {
//                     script {
//                         def duration = (System.currentTimeMillis() - startTime) / 1000
//                         stageData['Build Website'] = [
//                             status: currentBuild.result ?: "SUCCESS",
//                             duration: "${duration}s"
//                         ]
//                     }
//                 }
//             }
//         }

//         stage('Deploy to Render') {
//             steps {
//                 script {
//                     startTime = System.currentTimeMillis()
//                     sh """
//                     curl -X POST -H "Accept: application/json" \
//                     -H "Authorization: Bearer ${RENDER_API_KEY}" \
//                     https://api.render.com/v1/services/${RENDER_SERVICE_ID}/deploys
//                     """
//                 }
//             }
//             post {
//                 always {
//                     script {
//                         def duration = (System.currentTimeMillis() - startTime) / 1000
//                         stageData['Deploy to Render'] = [
//                             status: currentBuild.result ?: "SUCCESS",
//                             duration: "${duration}s"
//                         ]
//                     }
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             script {
//                 try {
//                     def jsonData = [
//                         pipelineName: env.JOB_NAME ?: "Unknown",
//                         buildNumber: env.BUILD_NUMBER ?: "Unknown",
//                         githubRepo: env.GIT_URL ?: "https://github.com/anshsehgal13/Portfolio",
//                         commitHash: env.GIT_COMMIT ?: "Unknown",
//                         executionTime: new Date().format("yyyy-MM-dd HH:mm:ss"),
//                         status: currentBuild.currentResult,
//                         stages: stageData
//                     ]

//                     def jsonContent = groovy.json.JsonOutput.toJson(jsonData)
//                     writeFile file: "pipeline_build_info.json", text: jsonContent
//                     echo "✅ Pipeline JSON Created: ${jsonContent}"

//                 } catch (Exception e) {
//                     echo "⚠️ Error writing JSON file: ${e}"
//                 }
//             }
//         }

//         success {
//             echo "✅ Pipeline completed successfully!"
//         }

//         failure {
//             echo "❌ Pipeline failed!"
//         }
//     }
// }






import groovy.json.JsonOutput

pipeline {
    agent any

    environment {
        RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"  // Replace with your actual Render Service ID
        METADATA_FILE = "pipeline_metadata.json"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    captureMetadata('Clone Repository')
                    git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio.git'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    captureMetadata('Install Dependencies')
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else {
                        echo 'No package.json found, skipping dependencies installation.'
                    }
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    captureMetadata('Build App')
                    if (fileExists('package.json')) {
                        sh 'npm run build'
                    } else {
                        echo 'No build step required for static site.'
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    captureMetadata('Deploy to Render')
                    sh '''
                    curl -X POST "https://api.render.com/deploy/srv-${RENDER_SERVICE_ID}?key=rnd_qXmPDBgzdjGTrvsQRnZcqoz8Z22k"
                    '''
                }
            }
        }
    }

    post {
        always {
            script {
                echo "🟢 Pipeline Execution Completed. Metadata saved in '${env.METADATA_FILE}'."
            }
        }
    }
}

// Function to capture and save metadata
def captureMetadata(stageName) {
    def startTime = new Date()
    
    try {
        echo "🔹 Stage: ${stageName} started at ${startTime}"

        def durationStart = System.currentTimeMillis()
        sleep 1  // Simulate execution time tracking
        def durationEnd = System.currentTimeMillis()
        def duration = (durationEnd - durationStart) / 1000.0 // Convert to seconds

        def metadata = [
            "Pipeline Name"        : env.JOB_NAME,
            "Step Name"            : stageName,
            "Build Number"         : env.BUILD_NUMBER,
            "Date/Time of Execution": startTime.toString(),
            "Step Duration (sec)"  : duration,
            "Success/Failure Status": currentBuild.result ?: 'SUCCESS'
        ]

        // Convert metadata to JSON
        def jsonMetadata = JsonOutput.toJson(metadata)

        // Append data to JSON file
        def filePath = "${env.WORKSPACE}/${env.METADATA_FILE}"
        if (fileExists(filePath)) {
            def existingData = readJSON(file: filePath)
            existingData << metadata
            writeJSON file: filePath, json: existingData
        } else {
            writeJSON file: filePath, json: [metadata]
        }

        echo "📊 Metadata saved: ${jsonMetadata}"
    } catch (Exception e) {
        echo "❌ Error in capturing metadata: ${e.message}"
    }
}
