plug_files = files (
    'Plug.vala',
    'Backend/PenSettings.vala',
    'Backend/RingerSettings.vala',
    'Backend/GeneralSettings.vala',
    'Views/General.vala',
    'Views/Pen.vala',
    'Views/Ringer.vala',
    'Widgets/SettingLabel.vala',
)

switchboard_dep = dependency ('switchboard-2.0')

shared_module (
    meson.project_name (),
    icon_res,
    plug_files,
    dependencies: [
        dependency ('glib-2.0'),
        dependency ('gio-2.0'),
        dependency ('gobject-2.0'),
        dependency ('granite'),
        dependency ('gtk+-3.0'),
        switchboard_dep
    ],
    install: true,
    install_dir: join_paths (switchboard_dep.get_pkgconfig_variable ('plugsdir'), 'hardware')
)
