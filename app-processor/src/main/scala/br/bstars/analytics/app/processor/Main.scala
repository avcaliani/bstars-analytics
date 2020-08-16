package br.bstars.analytics.app.processor

import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.SparkSession
import org.slf4j.LoggerFactory

object Main {

  private val log = LoggerFactory.getLogger(getClass)

  /**
   * Main method. Expected Args:
   * 01 - Pipeline Name [ raw | trusted ]
   *
   * @param args Arguments.
   */
  def main(args: Array[String]): Unit = {

    if (args.length == 0) {
      log.error("Argument 'Pipeline Name' is required!")
      sys.exit(1)
    }

    val spark = SparkSession.builder().getOrCreate()
    try {
      describe(spark, args)
      // TODO: Process
    } catch {
      case ex: Exception =>
        log.error("Unknown Error!", ex)
    }
    spark.close()
    sys.exit(0)
  }

  private def describe(spark: SparkSession, args: Array[String]): Unit = {
    log.info(s"App Env: ${Props.get("env")}")
    log.info(s"App Args: ${args.reduce(_ + ", " + _)}")
    log.info(s"Spark Version: ${spark.version}")
  }
}
