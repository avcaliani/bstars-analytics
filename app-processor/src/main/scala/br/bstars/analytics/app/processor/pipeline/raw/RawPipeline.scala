package br.bstars.analytics.app.processor.pipeline.raw

import br.bstars.analytics.app.processor.pipeline.Pipeline
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.SparkSession

/**
 * Raw Pipeline process.
 * This class will process data from transient zone to raw zone.
 *
 * @param spark Spark Session.
 */
class RawPipeline(spark: SparkSession) extends Pipeline {

  private val PIPELINE_NAME = getClass.getSimpleName
  private val TRANSIENT_USERS = Props.get("datalake.transient.users")
  private val RAW_USERS = Props.get("datalake.raw.users")

  override def run(): Unit = {
    log.info(s"Starting $PIPELINE_NAME...")
    spark.read
      .option("mode", "DROPMALFORMED")
      .json(TRANSIENT_USERS)
      .write
      .mode("overwrite")
      .json(RAW_USERS)
    log.info(s"$PIPELINE_NAME finished!")
  }

}
