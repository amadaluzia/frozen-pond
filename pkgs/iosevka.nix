{iosevka}:
iosevka.override {
  privateBuildPlan = ''
    [buildPlans.IosevkaCustom]
    family = "Myosevka"
    spacing = "normal"
    serifs = "sans"
    noCvSs = true
    exportGlyphNames = false
    noLigation = true

    [buildPlans.IosevkaCustom.variants]
    inherits = "ss17"
  '';
}
