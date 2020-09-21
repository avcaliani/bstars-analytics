package br.bstars.analytics.app.processor.util

import com.holdenkarau.spark.testing.{DataFrameSuiteBase, SharedSparkContext}
import org.junit.runner.RunWith
import org.scalatest.FunSuite
import org.scalatest.junit.JUnitRunner

@RunWith(classOf[JUnitRunner])
class ConvertUtilTest extends FunSuite with SharedSparkContext with DataFrameSuiteBase {

  test("Testing toSnake method") {
    assert("consulted_at" === ConvertUtil.toSnake("consulted_at"))
    assert("consulted_at" === ConvertUtil.toSnake("consultedAt"))
    assert("convert_2_snake" === ConvertUtil.toSnake("convert2Snake"))
    assert("_7_days_after" === ConvertUtil.toSnake("7DaysAfter"))
  }

}