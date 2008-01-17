module ActiveResourceExtension
  def find(*args)
    if multiple_query?(args)
      return super(:all, :params => { :identifiers => args.join(','), :detail => true })
    end

    scope   = args.slice!(0)
    options = convert_options(args.slice!(0) || {})
    super(scope, options)
              
  # empty elements result causes error in typecast_xml_value because of xmlns of springnote
  rescue RuntimeError
    []
  end
  
protected
  def multiple_query?(args)
    args.size > 1 && args[0].respond_to?(:to_int) && args[1].respond_to?(:to_int)
  end
  
  def convert_options(args)
    return args if args.empty? || args.include?(:from) || args.include?(:params)
    {:params => args}
  end
end