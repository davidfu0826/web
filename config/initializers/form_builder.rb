class ActionView::Helpers::FormBuilder

  def pagedown_input(method, options = {}, &block)
    @template.pagedown_input(@object_name,method,options,&block)
  end
end
