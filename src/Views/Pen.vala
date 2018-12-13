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

public class Tablet.PenView : Gtk.Grid {
    public Backend.PenSettings pen_settings { get; construct; }

    public PenView (Backend.PenSettings pen_settings) {
        Object (pen_settings: pen_settings);
    }

    construct {
        var glib_settings = new GLib.Settings ("org.gnome.desktop.peripherals.tablet.stylus");

        row_spacing = 12;
        column_spacing = 12;
    }
}
