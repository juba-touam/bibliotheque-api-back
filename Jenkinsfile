node("ci-node"){
	def GIT_COMMIT_HASH = ""

    stage("Checkout"){
		checkout scm
        GIT_COMMIT_HASH = sh (script: "git log -n 1 --pretty=format:'%H'", returnStdout: true)
    }

    //stage("Unit tests"){
	//	sh "chmod 777 mvnw && ./mvnw test"
    //}
	//
    //stage("Quality Analyses"){
	//	sh "./mvnw clean verify sonar:sonar \\\n" +
    //            "  -Dsonar.projectKey=bibliotheque-api \\\n" +
    //            "  -Dsonar.projectName='bibliotheque-api' \\\n" +
    //            "  -Dsonar.host.url=https://sonar.check-consulting.net \\\n" +
    //            "  -Dsonar.token=sqp_0d1d1f36f8523169f367dc51f2529f4b4f673629"
    //}

    stage("Build Jar file"){

			sh 'chmod +x mvnw'
        	sh './mvnw package -DskipTests'
    	}


    stage("Build Docker Image"){
		sh "sudo docker build -t mchekini/bibliotheque-api:$GIT_COMMIT_HASH ."
    }

    stage("Push Docker image"){
		withCredentials([usernamePassword(credentialsId: 'mchekini', passwordVariable: 'password', usernameVariable: 'username')]) {
			sh "sudo docker login -u $username -p $password"
            sh "sudo docker push mchekini/bibliotheque-api:$GIT_COMMIT_HASH"
            sh "sudo docker rmi mchekini/bibliotheque-api:$GIT_COMMIT_HASH"
        }
    }
}