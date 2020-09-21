package br.bstars.analytics.app.processor.pipeline

/**
 * Pipeline Trait.
 * This trait define the default method(s) in a pipeline.
 */
trait Pipeline {

  /**
   * Execute pipeline steps.
   */
  def run(): Unit = ???

}
