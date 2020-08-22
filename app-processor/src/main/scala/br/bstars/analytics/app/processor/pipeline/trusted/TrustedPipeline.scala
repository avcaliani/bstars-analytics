package br.bstars.analytics.app.processor.pipeline.trusted

import br.bstars.analytics.app.processor.pipeline.Pipeline
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.SparkSession

/**
 * Trusted Pipeline process.
 * This class will process data from raw zone to trusted zone.
 *
 * @param spark Spark Session.
 */
class TrustedPipeline(spark: SparkSession) extends Pipeline {

  private val RAW_USERS = Props.get("datalake.raw.users")
  private val TRUSTED_USERS = Props.get("datalake.transient.users")

  override def run(): Unit = {
    // TODO: Implement it.
    log.info(s"Starting '${getClass.getSimpleName}'...")
    spark.read.json(RAW_USERS).show()
  }
}
