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

  private val TRANSIENT_USERS = Props.get("datalake.transient.users")
  private val RAW_USERS = Props.get("datalake.raw.users")

  override def run(): Unit = {
    // TODO: Implement it.
    log.info(s"Starting '${getClass.getSimpleName}'...")
    spark.read.json(TRANSIENT_USERS).show()
  }

}
