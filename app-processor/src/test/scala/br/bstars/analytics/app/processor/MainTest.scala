package br.bstars.analytics.app.processor

import com.holdenkarau.spark.testing.{DataFrameSuiteBase, SharedSparkContext}
import org.junit.runner.RunWith
import org.scalatest.FunSuite
import org.scalatest.junit.JUnitRunner

@RunWith(classOf[JUnitRunner])
class MainTest extends FunSuite with SharedSparkContext with DataFrameSuiteBase {

  test("Dummy Test 01") {
    val list = List(1, 2, 3, 4)
    val rdd = sc.parallelize(list)
    assert(rdd.count === list.length)
  }

  test("Dummy Test 02") {
    import spark.implicits._

    val input1 = sc.parallelize(List(1, 2, 3)).toDF
    assertDataFrameEquals(input1, input1) // equal

    val input2 = sc.parallelize(List(4, 5, 6)).toDF
    intercept[org.scalatest.exceptions.TestFailedException] {
      assertDataFrameEquals(input1, input2) // not equal
    }
  }
}