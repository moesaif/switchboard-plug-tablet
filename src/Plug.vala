/*
 * Copyright (c) 2011-2018 elementary, Inc. (https://elementary.io)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA.
 */

public class Tablet.Plug : Switchboard.Plug {
    private Backend.GeneralSettings general_settings;
    private Backend.PenSettings pen_settings;
    private Backend.RingerSettings ringer_settings;

    private Gtk.Stack stack;
    private Gtk.ScrolledWindow scrolled;

    private GeneralView general_view;
    private PenView pen_view;
    private RingerView ringer_view;

    public Plug () {
        var settings = new Gee.TreeMap<string, string?> (null, null);
        settings.set ("input/tablet/pen", "pen");
        settings.set ("input/tablet/ringer", "ringer");
        settings.set ("input/tablet", "general");

        Object (
            category: Category.HARDWARE,
            code_name: "pantheon-tablet",
            display_name: _("Graphic Tablet"),
            description: _("Configure graphic tablet"),
            icon: "input-tablet",
            supported_settings: settings
        );
    }

    public override Gtk.Widget get_widget () {
        if (scrolled == null) {
            load_settings ();

            weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
            default_theme.add_resource_path ("/github/alecaddd/switchboard/tablet");

            general_view = new GeneralView (general_settings);
            pen_view = new PenView (pen_settings);
            ringer_view = new RingerView (ringer_settings);

            stack = new Gtk.Stack ();
            stack.margin = 12;
            stack.add_titled (general_view, "general", _("General"));
            stack.add_titled (pen_view, "pen", _("Pen"));
            stack.add_titled (ringer_view, "ringer", _("Ringer"));

            var switcher = new Gtk.StackSwitcher ();
            switcher.halign = Gtk.Align.CENTER;
            switcher.homogeneous = true;
            switcher.margin = 12;
            switcher.stack = stack;

            var main_grid = new Gtk.Grid ();
            main_grid.halign = Gtk.Align.CENTER;
            main_grid.attach (switcher, 0, 0);
            main_grid.attach (stack, 0, 1);

            scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.add (main_grid);
            scrolled.show_all ();
        }

        return scrolled;
    }

    public override void shown () {
    }

    public override void hidden () {
    }

    public override void search_callback (string location) {
        switch (location) {
            case "pen":
                stack.set_visible_child_name ("pen");
                break;
            case "ringer":
                stack.set_visible_child_name ("ringer");
                break;
            case "general":
            default:
                stack.set_visible_child_name ("general");
                break;
        }
    }

    /* 'search' returns results like ("Keyboard → Behavior → Duration", "keyboard<sep>behavior") */
    public override async Gee.TreeMap<string, string> search (string search) {
        var search_results = new Gee.TreeMap<string, string> ((GLib.CompareDataFunc<string>)strcmp, (Gee.EqualDataFunc<string>)str_equal);
        search_results.set ("%s → %s".printf (display_name, _("Tablet")), "general");
        //  search_results.set ("%s → %s".printf (display_name, _("Mouse")), "mouse");
        //  search_results.set ("%s → %s → %s".printf (display_name, _("Mouse"), _("Pointer speed")), "mouse");
        //  search_results.set ("%s → %s".printf (display_name, _("Touchpad")), "touchpad");
        //  search_results.set ("%s → %s → %s".printf (display_name, _("Touchpad"), _("Pointer speed")), "touchpad");

        return search_results;
    }

    private void load_settings () {
        pen_settings = new Backend.PenSettings ();
        ringer_settings = new Backend.RingerSettings ();
    }
}

public Switchboard.Plug get_plug (Module module) {
    debug ("Activating Tablet plug");

    var plug = new Tablet.Plug ();

    return plug;
}

