package br.bstars.analytics.app.processor.pipeline.refined

import br.bstars.analytics.app.processor.pipeline.Pipeline
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.SparkSession

/**
 * Refined Pipeline process.
 * This class will process data from trusted zone to refined zone.
 *
 * @param spark Spark Session.
 */
class RefinedPipeline(spark: SparkSession) extends Pipeline {

  private val TRUSTED_USERS = Props.get("datalake.trusted.users")
  private val REFINED_USERS = Props.get("datalake.refined.users")

  override def run(): Unit = {
    // TODO: Implement it.
    log.info(s"Starting '${getClass.getSimpleName}'...")
  }
}
