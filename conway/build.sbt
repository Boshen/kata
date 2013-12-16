scalaVersion := "2.10.3"

libraryDependencies ++= Seq(
  "org.scalatest" %% "scalatest" % "2.0" % "test",
  "org.mockito" % "mockito-core" % "1.9.5",
  "com.typesafe.akka" %% "akka-actor" % "2.2.3",
  "org.scala-lang" % "scala-swing" % "2.10.3"
)

scalacOptions ++= Seq("-feature")
