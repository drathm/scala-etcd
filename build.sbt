import AssemblyKeys._

organization := "net.nikore"

version := "0.3"

scalaVersion := "2.11.2"

scalacOptions := Seq("-unchecked", "-deprecation", "-encoding", "utf8")

resolvers ++= Seq(
      "Sonatype repo" at "https://oss.sonatype.org/content/repositories/releases/",
      "gseitz@github" at "http://gseitz.github.com/maven/",
      "spray repo" at "http://repo.spray.io",
      "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases"
)

libraryDependencies ++= {
  val akkaV = "2.3.4"
  val sprayV = "1.3.1"
  Seq(
    "io.spray"                      %%    "spray-client"        % sprayV,
    "io.spray"                      %%    "spray-json"          % "1.2.6",
    "com.typesafe.akka"             %%    "akka-actor"          % akkaV,
    "com.novocode"                  %     "junit-interface"     % "0.9" % "test",
    "org.scala-lang.modules"        %%    "scala-xml"           % "1.0.2",
    "org.scalatest"                 %%    "scalatest"           % "2.2.1" % "test"
  )
}

assemblySettings

mergeStrategy in assembly <<= (mergeStrategy in assembly) { (old) =>
  {
    case x => {
      val oldstrat = old(x)
      if (oldstrat == MergeStrategy.deduplicate) MergeStrategy.first
      else oldstrat
    }
  }
}



Revolver.settings

net.virtualvoid.sbt.graph.Plugin.graphSettings
