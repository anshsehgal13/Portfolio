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

    post {
        always {
            script {
                try {
                    def jsonData = [
                        pipelineName: env.JOB_NAME,
                        buildNumber: env.BUILD_NUMBER,
                        githubRepo: env.GIT_URL ?: "Unknown",
                        commitHash: env.GIT_COMMIT ?: "Unknown",
                        executionTime: new Date().format("yyyy-MM-dd HH:mm:ss"),
                        status: currentBuild.currentResult
                    ]

                    def jsonContent = groovy.json.JsonOutput.toJson(jsonData)
                    writeFile file: "pipeline_build_info.json", text: jsonContent
                    echo "✅ Pipeline Build Info JSON Created: ${jsonContent}"

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
