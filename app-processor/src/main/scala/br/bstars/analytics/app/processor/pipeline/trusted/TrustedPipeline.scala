package br.bstars.analytics.app.processor.pipeline.trusted

import br.bstars.analytics.app.processor.pipeline.Pipeline
import br.bstars.analytics.app.processor.util.{ConvertUtil, Props}
import org.apache.spark.sql.functions.col
import org.apache.spark.sql.{DataFrame, SparkSession}

/**
 * Trusted Pipeline process.
 * This class will process data from raw zone to trusted zone.
 *
 * @param spark Spark Session.
 */
class TrustedPipeline(spark: SparkSession) extends Pipeline {

  private val RAW_USERS = Props.get("datalake.raw.users")

  override def run(): Unit = {
    val df = renameCols(spark.read.json(RAW_USERS))
    new UserProcessor().process(df)
  }

  private def renameCols(df: DataFrame): DataFrame = {
    val cols = df.columns.map(
      name => col(name).alias(ConvertUtil.toSnake(name))
    )
    df.select(cols: _*)
  }

}
