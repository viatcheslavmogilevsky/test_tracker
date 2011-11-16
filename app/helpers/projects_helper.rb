module ProjectsHelper

  def tasks_max_count(a,b,c)
    [a.count,b.count,c.count].max
  end

end
