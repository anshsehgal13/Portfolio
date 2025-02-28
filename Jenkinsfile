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


// import groovy.json.JsonSlurperClassic
// import groovy.json.JsonOutput

// pipeline {
//     agent any

//     environment {
//         JENKINS_USER = "anshsehgal"
//         JENKINS_TOKEN = "1173445fd81fc4a572a6917cf51fe73c21"
//         API_ENDPOINT = "http://13.60.71.149:3000/pipeline-metadata"
//         JENKINS_URL = "http://51.21.196.223:8080/"
//         JOB_NAME = "PortfolioCICD"
//         RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"
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
//                         echo "⚠ No package.json found, skipping dependency installation."
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
//                         echo "⚠ No build step required for static HTML site."
//                     }
//                 }
//             }
//         }

//         stage('Deploy to Render') {
//             steps {
//                 script {
//                     sh 'echo "🚀 Deploying to Render..."'
//                 }
//             }
//         }
//     }

//     post {
//         always {
//             script {
//                 try {
//                     def credentials = "${JENKINS_USER}:${JENKINS_TOKEN}".bytes.encodeBase64().toString()
//                     def crumb = null
//                     def buildData = null
//                     def stageData = null

//                     // 🔹 Fetch CSRF Crumb (if required)
//                     try {
//                         def crumbResponse = httpRequest(
//                             acceptType: 'APPLICATION_JSON',
//                             url: "${JENKINS_URL}/crumbIssuer/api/json",
//                             customHeaders: [[name: 'Authorization', value: "Basic ${credentials}"]]
//                         )
//                         crumb = new JsonSlurperClassic().parseText(crumbResponse.content).crumb
//                         echo "✅ CSRF Crumb fetched: ${crumb}"
//                     } catch (Exception e) {
//                         echo "⚠ Crumb fetch failed: ${e.message}"
//                     }

//                     // 🔹 Fetch Build Metadata
//                     try {
//                         def buildApiUrl = "${JENKINS_URL}/job/${JOB_NAME}/lastBuild/api/json"
//                         def buildResponse = httpRequest(
//                             acceptType: 'APPLICATION_JSON',
//                             url: buildApiUrl,
//                             customHeaders: crumb ? [
//                                 [name: 'Authorization', value: "Basic ${credentials}"],
//                                 [name: 'Jenkins-Crumb', value: crumb]
//                             ] : [[name: 'Authorization', value: "Basic ${credentials}"]]
//                         )
//                         buildData = new JsonSlurperClassic().parseText(buildResponse.content)
//                         echo "✅ Build Metadata Fetched Successfully"
//                     } catch (Exception e) {
//                         echo "⚠ Build metadata fetch failed: ${e.message}"
//                     }

//                     // 🔹 Fetch Stage Data
//                     try {
//                         def stageApiUrl = "${JENKINS_URL}/job/${JOB_NAME}/lastBuild/wfapi/describe"
//                         def stageResponse = httpRequest(
//                             acceptType: 'APPLICATION_JSON',
//                             url: stageApiUrl,
//                             customHeaders: crumb ? [
//                                 [name: 'Authorization', value: "Basic ${credentials}"],
//                                 [name: 'Jenkins-Crumb', value: crumb]
//                             ] : [[name: 'Authorization', value: "Basic ${credentials}"]]
//                         )
//                         def rawStageData = stageResponse.content
//                         echo "🔹 Raw Stage Data: ${rawStageData}"
                        
//                         if (rawStageData && rawStageData != "null") {
//                             stageData = new JsonSlurperClassic().parseText(rawStageData)
//                             echo "✅ Stage Metadata Fetched Successfully"
//                         } else {
//                             echo "⚠ Stage metadata response was empty or null."
//                         }
//                     } catch (Exception e) {
//                         echo "⚠ Stage metadata fetch failed: ${e.message}"
//                     }

//                     // 🔹 Combine & Post Data
//                     if (buildData && stageData) {
//                         def combinedData = [build: buildData, steps: stageData]
//                         echo "🔹 Final API Payload: ${JsonOutput.prettyPrint(JsonOutput.toJson(combinedData))}"

//                         try {
//                             httpRequest(
//                                 url: API_ENDPOINT,
//                                 httpMode: 'POST',
//                                 contentType: 'APPLICATION_JSON',
//                                 requestBody: JsonOutput.toJson(combinedData),
//                                 customHeaders: [[name: 'Authorization', value: "Basic ${credentials}"]]
//                             )
//                             echo "✅ Data successfully posted to API."
//                         } catch (Exception e) {
//                             echo "⚠ API post request failed: ${e.message}"
//                         }
//                     } else {
//                         echo "⚠ Skipping API post due to missing build or stage data."
//                     }
//                 } catch (Exception e) {
//                     echo "❌ Unexpected error in post condition: ${e.message}"
//                 }
//             }
//         }
//     }
// }







import groovy.json.JsonSlurperClassic
import groovy.json.JsonOutput
import java.security.MessageDigest
import javax.crypto.Mac
import javax.crypto.spec.SecretKeySpec
import java.util.Base64

pipeline {
    agent any

    environment {
        JENKINS_USER = "anshsehgal"
        JENKINS_TOKEN = "1173445fd81fc4a572a6917cf51fe73c21"
        API_ENDPOINT = "http://13.60.71.149:3000/pipeline-metadata"
        JENKINS_URL = "http://51.21.196.223:8080/"
        JOB_NAME = "PortfolioCICD"
        RENDER_SERVICE_ID = "csn8pkdds78s7391dpsg"
        SECRET_KEY = "randomsecretkey"  // Change this to a strong secret key
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
                        echo "⚠ No package.json found, skipping dependency installation."
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
                        echo "⚠ No build step required for static HTML site."
                    }
                }
            }
        }

        stage('Deploy to Render') {
            steps {
                script {
                    sh 'echo "🚀 Deploying to Render..."'
                }
            }
        }
    }

    post {
        always {
            script {
                try {
                    def credentials = "${JENKINS_USER}:${JENKINS_TOKEN}".bytes.encodeBase64().toString()
                    def crumb = null
                    def buildData = null
                    def stageData = null

                    // 🔹 Fetch CSRF Crumb (if required)
                    try {
                        def crumbResponse = httpRequest(
                            acceptType: 'APPLICATION_JSON',
                            url: "${JENKINS_URL}/crumbIssuer/api/json",
                            customHeaders: [[name: 'Authorization', value: "Basic ${credentials}"]]
                        )
                        crumb = new JsonSlurperClassic().parseText(crumbResponse.content).crumb
                        echo "✅ CSRF Crumb fetched: ${crumb}"
                    } catch (Exception e) {
                        echo "⚠ Crumb fetch failed: ${e.message}"
                    }

                    // 🔹 Fetch Build Metadata
                    try {
                        def buildApiUrl = "${JENKINS_URL}/job/${JOB_NAME}/lastBuild/api/json"
                        def buildResponse = httpRequest(
                            acceptType: 'APPLICATION_JSON',
                            url: buildApiUrl,
                            customHeaders: crumb ? [
                                [name: 'Authorization', value: "Basic ${credentials}"],
                                [name: 'Jenkins-Crumb', value: crumb]
                            ] : [[name: 'Authorization', value: "Basic ${credentials}"]]
                        )
                        buildData = new JsonSlurperClassic().parseText(buildResponse.content)
                        echo "✅ Build Metadata Fetched Successfully"
                    } catch (Exception e) {
                        echo "⚠ Build metadata fetch failed: ${e.message}"
                    }

                    // 🔹 Fetch Stage Data
                    try {
                        def stageApiUrl = "${JENKINS_URL}/job/${JOB_NAME}/lastBuild/wfapi/describe"
                        def stageResponse = httpRequest(
                            acceptType: 'APPLICATION_JSON',
                            url: stageApiUrl,
                            customHeaders: crumb ? [
                                [name: 'Authorization', value: "Basic ${credentials}"],
                                [name: 'Jenkins-Crumb', value: crumb]
                            ] : [[name: 'Authorization', value: "Basic ${credentials}"]]
                        )
                        def rawStageData = stageResponse.content
                        echo "🔹 Raw Stage Data: ${rawStageData}"
                        
                        if (rawStageData && rawStageData != "null") {
                            stageData = new JsonSlurperClassic().parseText(rawStageData)
                            echo "✅ Stage Metadata Fetched Successfully"
                        } else {
                            echo "⚠ Stage metadata response was empty or null."
                        }
                    } catch (Exception e) {
                        echo "⚠ Stage metadata fetch failed: ${e.message}"
                    }

                    // 🔹 Combine & Secure Data
                    if (buildData && stageData) {
                        def combinedData = [build: buildData, steps: stageData]
                        def jsonPayload = JsonOutput.toJson(combinedData)
                        def signature = generateHMAC(jsonPayload, SECRET_KEY)
                        echo "🔹 Final API Payload: ${JsonOutput.prettyPrint(jsonPayload)}"
                        echo "🔹 Generated HMAC Signature: ${signature}"

                        // 🔹 Send Secure Data to API
                        try {
                            httpRequest(
                                url: API_ENDPOINT,
                                httpMode: 'POST',
                                contentType: 'APPLICATION_JSON',
                                requestBody: jsonPayload,
                                customHeaders: [
                                    [name: 'Authorization', value: "Basic ${credentials}"],
                                    [name: 'X-Signature', value: signature]
                                ]
                            )
                            echo "✅ Data successfully posted to API."
                        } catch (Exception e) {
                            echo "⚠ API post request failed: ${e.message}"
                        }
                    } else {
                        echo "⚠ Skipping API post due to missing build or stage data."
                    }
                } catch (Exception e) {
                    echo "❌ Unexpected error in post condition: ${e.message}"
                }
            }
        }
    }
}

// 🔹 HMAC SHA-256 Hashing Function
def generateHMAC(String data, String secretKey) {
    try {
        Mac mac = Mac.getInstance("HmacSHA256")
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256")
        mac.init(secretKeySpec)
        byte[] hashBytes = mac.doFinal(data.getBytes("UTF-8"))
        return Base64.getEncoder().encodeToString(hashBytes)
    } catch (Exception e) {
        echo "⚠ HMAC Generation Failed: ${e.message}"
        return ""
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
//}



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




