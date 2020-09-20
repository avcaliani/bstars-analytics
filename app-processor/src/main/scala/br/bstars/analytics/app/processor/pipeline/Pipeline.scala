package br.bstars.analytics.app.processor.pipeline

import org.slf4j.{Logger, LoggerFactory}

/**
 * Pipeline Trait.
 * This trait define the default method(s) in a pipeline.
 */
trait Pipeline {

  protected val log: Logger = LoggerFactory.getLogger(getClass)

  /**
   * Execute pipeline steps.
   */
  def run(): Unit = ???

}
