package br.bstars.analytics.app.processor.pipeline.trusted

import br.bstars.analytics.app.processor.data.User
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions.{col, regexp_replace}

/**
 * User Processor.
 */
class UserProcessor extends User {

  private val TRUSTED_USERS = Props.get("datalake.trusted.users")

  def process(df: DataFrame): Unit = {
    val users = filterCols(df)
    parse(users)
      .write
      .partitionBy(TAG)
      .mode("overwrite")
      .parquet(TRUSTED_USERS)
  }

  private def filterCols(df: DataFrame): DataFrame = df.select(
    TAG,
    NAME,
    EXP_LEVEL,
    CONSULTED_ON,
    TROPHIES,
    HIGHEST_TROPHIES,
    POWER_PLAY_POINTS,
    HIGHEST_POWER_PLAY_POINTS,
    _3VS_3_VICTORIES,
    BEST_ROBO_RUMBLE_TIME,
    BEST_TIME_AS_BIG_BRAWLER,
    DUO_VICTORIES,
    SOLO_VICTORIES,
  )

  private def parse(df: DataFrame): DataFrame = {
    df.withColumn(TAG, regexp_replace(col(TAG), "%", ""))
    // TODO: OrderBy "TAG" and "Consulted On"
  }

}
