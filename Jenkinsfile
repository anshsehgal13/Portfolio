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
        RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"
        REPO_URL = "https://github.com/anshsehgal13/Portfolio.git"
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    def startTime = System.currentTimeMillis()
                    git branch: 'main', url: REPO_URL
                    def endTime = System.currentTimeMillis()
                    env.CLONE_TIME = endTime - startTime
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    def startTime = System.currentTimeMillis()
                    if (fileExists('package.json')) {
                        sh 'npm install'
                    } else {
                        echo 'No package.json found, skipping dependencies installation.'
                    }
                    def endTime = System.currentTimeMillis()
                    env.INSTALL_TIME = endTime - startTime
                }
            }
        }

        stage('Build App') {
            steps {
                script {
                    def startTime = System.currentTimeMillis()
                    if (fileExists('package.json')) {
                        sh 'npm run build'
                    } else {
                        echo 'No build step required for static site.'
                    }
                    def endTime = System.currentTimeMillis()
                    env.BUILD_TIME = endTime - startTime
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    def startTime = System.currentTimeMillis()
                    sh "curl -X POST 'https://api.render.com/deploy/srv-${RENDER_SERVICE_ID}?key=rnd_qXmPDBgzdjGTrvsQRnZcqoz8Z22k'"
                    def endTime = System.currentTimeMillis()
                    env.DEPLOY_TIME = endTime - startTime
                }
            }
        }
    }

    post {
        always {
            script {
                try {
                    // Extract pipeline build info and write to JSON
                    def jsonData = [
                        pipelineName: env.JOB_NAME,
                        buildNumber: env.BUILD_NUMBER,
                        githubRepo: env.GIT_URL ?: "Unknown",
                        commitHash: env.GIT_COMMIT ?: "Unknown",
                        executionTime: new Date().format("yyyy-MM-dd HH:mm:ss"),
                        status: currentBuild.currentResult
                    ]
                    
                    // Convert to JSON and write to file
                    def jsonContent = groovy.json.JsonOutput.toJson(jsonData)
                    writeFile file: "pipeline_build_info.json", text: jsonContent
    
                    // Print JSON file content for verification
                    echo "Pipeline Build Info JSON Created: ${jsonContent}"
    
                } catch (Exception e) {
                    echo "⚠️ Error writing JSON file: ${e}"
                }
            }
        }
    
        success {
            echo "✅ Pipeline completed successfully!"
        }
    
        failure {
            echo "❌ Pipeline failed!"
        }
    }

    }
}

