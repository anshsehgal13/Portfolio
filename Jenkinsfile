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



pipeline {
    agent any

    environment {
        RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg" // Your hardcoded Render service ID
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/anshsehgal13/Portfolio/'
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else {
                        echo "No package.json found, skipping dependency installation."
                    }
                }
            }
        }

        stage('Build Website') {
            steps {
                script {
                    if (fileExists('package.json')) {
                        sh 'npm run build'
                    } else {
                        echo "No build step required for static HTML site."
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    sh """
                    curl -X POST -H "Accept: application/json" \
                    -H "Authorization: Bearer YOUR_RENDER_API_KEY" \
                    https://api.render.com/v1/services/$RENDER_SERVICE_ID/deploys
                    """
                }
            }
        }
    }

    // post {
    //     always {
    //         script {
    //             try {
    //                 def jsonData = [
    //                     pipelineName: env.JOB_NAME,
    //                     buildNumber: env.BUILD_NUMBER,
    //                     githubRepo: env.GIT_URL ?: "Unknown",
    //                     commitHash: env.GIT_COMMIT ?: "Unknown",
    //                     executionTime: new Date().format("yyyy-MM-dd HH:mm:ss"),
    //                     status: currentBuild.currentResult
    //                 ]

    //                 def jsonContent = groovy.json.JsonOutput.toJson(jsonData)
    //                 writeFile file: "pipeline_build_info.json", text: jsonContent
    //                 echo "✅ Pipeline Build Info JSON Created: ${jsonContent}"

    //             } catch (Exception e) {
    //                 echo "⚠️ Error writing JSON file: ${e}"
    //             }
    //         }
    //     }

    //     success {
    //         echo "✅ Pipeline completed successfully!"
    //     }

    //     failure {
    //         echo "❌ Pipeline failed!"
    //     }
    // }
}



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




