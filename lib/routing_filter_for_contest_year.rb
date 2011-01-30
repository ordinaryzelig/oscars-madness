module RoutingFilter
  class ContestYear < Filter
    def around_recognize(path, env, &block)
      contest_year = extract_segment!(%r{^/(\d{4})(?=/|$)}, path)
      yield.tap do |params|
        params[:contest_year] = contest_year if contest_year
      end
    end

    def around_generate(*args, &block)
      # remove :contest_year in params if it's there.
      params = args.extract_options!
      contest_year = params.delete(:contest_year)
      args << params # put the params back as it was without :contest_year.
      yield.tap do |result|
        prepend_segment!(result, contest_year.to_s) if contest_year
      end
    end
  end
end
