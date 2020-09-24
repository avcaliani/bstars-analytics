package br.bstars.analytics.app.processor.pipeline.trusted

import br.bstars.analytics.app.processor.data.User
import br.bstars.analytics.app.processor.util.Props
import org.apache.spark.sql.functions.{col, lit, regexp_replace}
import org.apache.spark.sql.{Column, DataFrame}

/**
 * User Processor.
 */
class UserProcessor extends User {

  private val TRUSTED_USERS = Props.get("datalake.trusted.users")

  def process(df: DataFrame): Unit = {
    val users = parse(filterCols(df))
    users.printSchema
    users
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

  private def parse(users: DataFrame): DataFrame =
    users
      .na.fill(0, Seq(POWER_PLAY_POINTS, HIGHEST_POWER_PLAY_POINTS))
      .withColumn(TAG, regexp_replace(col(TAG), "%", ""))
      .withColumn(BEST_TIME_AS_BIG_BRAWLER, toSeconds(BEST_TIME_AS_BIG_BRAWLER))
      .withColumn(BEST_ROBO_RUMBLE_TIME, toSeconds(BEST_ROBO_RUMBLE_TIME))
      .orderBy(TAG, CONSULTED_ON)

  private def toSeconds(colName: String): Column =
    col(colName) * lit(60)

}
