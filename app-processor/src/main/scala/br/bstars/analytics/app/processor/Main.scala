package br.bstars.analytics.app.processor

import br.bstars.analytics.app.processor.pipeline.PipelineFactory
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.SparkSession
import org.slf4j.LoggerFactory

/**
 * Application main class.
 */
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
      log.info(s"Starting '${args(0)}'...")
      PipelineFactory.instance(spark, args(0)).run()
      log.info(s"The process has been finished!")
    }
    finally {
      spark.close()
    }
  }

  private def describe(spark: SparkSession, args: Array[String]): Unit = {
    log.info(s"App Env: ${Props.get("env")}")
    log.info(s"App Args: ${args.reduce(_ + ", " + _)}")
    log.info(s"Spark Version: ${spark.version}")
  }
}
