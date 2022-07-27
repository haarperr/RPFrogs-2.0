NP = {}
NP.AdminMenu = {}
NP.Coords = {}

NP.AdminMenu.Action = {}
NP.AdminMenu.Category = {}
NP.AdminMenu.Sidebar = {}
NP.AdminMenu.PlayerList = {}

NP.AdminMenu.DebugEnabled = false
NP.AdminMenu.Opened = false;
NP.AdminMenu.IsGeneratingDropdown = false;

NP.AdminMenu.Action.SelectedCat = null;
NP.AdminMenu.Action.Selected = "All";
NP.AdminMenu.Sidebar.Selected = "Actions";
NP.AdminMenu.Sidebar.Size = "Small";

NP.AdminMenu.FavoritedItems = {};
NP.AdminMenu.PinnedTargets = {};
NP.AdminMenu.EnabledItems = {};
NP.AdminMenu.Settings = {};

NP.AdminMenu.Players = null;
NP.AdminMenu.Items = null;
NP.AdminMenu.CurrentTarget = null;

NP.AdminMenu.Update = function(Data) {
    DebugMessage(`Menu Updating`);
    NP.AdminMenu.FavoritedItems = Data.Favorited;
    NP.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    NP.AdminMenu.Settings = Data.MenuSettings;
    NP.AdminMenu.Players = Data.AllPlayers
    NP.AdminMenu.Items = Data.AdminItems
    NP.AdminMenu.LoadItems();
}
 
NP.AdminMenu.Open = function(Data) {
    DebugMessage(`Menu Opening`);
    NP.AdminMenu.DebugEnabled = Data.Debug;
    NP.AdminMenu.FavoritedItems = Data.Favorited;
    NP.AdminMenu.PinnedTargets = Data.PinnedPlayers;
    NP.AdminMenu.Settings = Data.MenuSettings;
    $('.menu-main-container').css('pointer-events', 'auto');
    $('.menu-main-container').fadeIn(450, function() {
        $('.menu-page-actions-search input').focus();
        if (NP.AdminMenu.Items == null && NP.AdminMenu.Players == null) {
            NP.AdminMenu.Players = Data.AllPlayers
            NP.AdminMenu.Items = Data.AdminItems
            if (NP.AdminMenu.Sidebar.Selected == 'Actions') {
                $('.menu-pages').find(`[data-Page="${NP.AdminMenu.Sidebar.Selected}"`).fadeIn(150);
                NP.AdminMenu.LoadItems();
            }
        };
        NP.AdminMenu.Players = Data.AllPlayers
        NP.AdminMenu.Opened = true;
    });
}


NP.AdminMenu.Close = function() {
    DebugMessage(`Menu Closing`);
    NP.AdminMenu.ClearDropdown();
    $.post(`https://${GetParentResourceName()}/Admin/Close`);
    $('.menu-main-container').css('pointer-events', 'none');
    $('.menu-main-container').fadeOut(150, function() {
        NP.AdminMenu.Opened = false; 
    });
}

NP.AdminMenu.ChangeSize = function() {
    if (NP.AdminMenu.Sidebar.Size == 'Small') {
        $('.menu-size-change').html('<i class="fas fa-chevron-right"></i>');
        NP.AdminMenu.Sidebar.Size = 'Large';
        $('.menu-main-container').css({
            width: 50+"%",
            right: 25+"%",
        });
    } else {
        $('.menu-size-change').html('<i class="fas fa-chevron-left"></i>');
        NP.AdminMenu.Sidebar.Size = 'Small';
        $('.menu-main-container').css({
            width: 24.24+"%",
            right: 3+"%",
        });
    }
}

NP.Coords.Copy = function(Data) {
    let TextArea = document.createElement('textarea');
    let Selection = document.getSelection();
    TextArea.textContent = Data.Coords;
    document.body.appendChild(TextArea);
    Selection.removeAllRanges();
    TextArea.select();
    document.execCommand('copy');
    Selection.removeAllRanges();
    document.body.removeChild(TextArea);
}

// [ CLICKS ] \\

$(document).on('click', '.menu-size-change', function(e) {
    e.preventDefault();
    NP.AdminMenu.ChangeSize()
});

$(document).on('click', '.menu-current-target', function(e){
    $(this).parent().find('.ui-styles-input').each(function(Elem, Obj){
        if ($(this).find('input').data("PlayerId")) {
            if (NP.AdminMenu.CurrentTarget != null) {
                if ($('.admin-menu-item').find('.admin-menu-items-option-input').first().find('.ui-input-label').text() == 'Player') {
                    $(this).find('input').data("PlayerId", null)
                    $(this).find('input').val(" ");
                }
            }
        }
    });
    $('.admin-menu-items').animate({
        'max-height': 72.6+'vh',
    }, 100);
    $('.menu-current-target').fadeOut(150);
    NP.AdminMenu.CurrentTarget = null;
});

// [ FUNCTIONS ] \\

DebugMessage = function(Message) {
    if (NP.AdminMenu.DebugEnabled) {
        console.log(`[DEBUG]: ${Message}`);
    }
}

// [ LISTENER ] \\

document.addEventListener('DOMContentLoaded', (event) => {
    DebugMessage(`Menu Initialised`)
    NP.AdminMenu.Action.SelectedCat = $('.menu-page-action-header-categories').find('.active');
    window.addEventListener('message', function(event){
        let Action = event.data.Action;
        let Data = event.data
        switch(Action) {
            case "Open":
                NP.AdminMenu.Open(Data);
                break;
            case "Close":
                if (!NP.AdminMenu.Opened) return;
                NP.AdminMenu.Close();
                break;
            case "Update":
                if (!NP.AdminMenu.Opened) return;
                NP.AdminMenu.Update(Data);
                break;
            case "SetItemEnabled":
                NP.AdminMenu.EnabledItems[Data.Name] = Data.State;
                Data.State ? $(`#admin-option-${Data.Name}`).addClass('enabled') : $(`#admin-option-${Data.Name}`).removeClass('enabled');
                break;
            case 'copyCoords':
                NP.Coords.Copy(event.data);
                break;
        }
    });
});

$(document).on({
    keydown: function(e) {
        if (e.keyCode == 27 && NP.AdminMenu.Opened) {
            NP.AdminMenu.Close();
        }
    },
});