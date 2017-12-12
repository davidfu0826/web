module PositionHelper
  def position_kinds
    Position.kinds.keys.map { |c| [position_kind(c), c] }
  end

  def position_kind(k)
    t("model.position.kinds.#{k}")
  end
end