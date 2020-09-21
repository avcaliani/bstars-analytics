package br.bstars.analytics.app.processor.data

/**
 * User Dataset Columns.
 */
trait User {

  // User Data
  val TAG = "tag"
  val NAME = "name"
  val EXP_LEVEL = "exp_level"
  val CONSULTED_ON = "consulted_on"

  // Trophies
  val TROPHIES = "trophies"
  val HIGHEST_TROPHIES = "highest_trophies"

  // Power Play
  val POWER_PLAY_POINTS = "power_play_points"
  val HIGHEST_POWER_PLAY_POINTS = "highest_power_play_points"

  // Game Modes
  val _3VS_3_VICTORIES = "_3vs_3_victories"
  val BEST_ROBO_RUMBLE_TIME = "best_robo_rumble_time"
  val BEST_TIME_AS_BIG_BRAWLER = "best_time_as_big_brawler"
  val DUO_VICTORIES = "duo_victories"
  val SOLO_VICTORIES = "solo_victories"

}
