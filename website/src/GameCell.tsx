import React from 'react';
import IconButton from '@material-ui/core/IconButton';
import RightIcon from '@material-ui/icons/KeyboardArrowRight';
import './Game.css';

export interface Game {
  id: string;
  name: string;
  icon: string;
  description: string;
  short_desc: string;
  code: string;
  theme: string;
}

function GameCell(props: any) {
  const { game } = props;
  return (
    <div className="Game">
      <img src={game.icon} alt="game-thumbnail" />
      <p>
        <b>{game.name}</b>
        {game.short_desc}
      </p>
      <IconButton
        aria-label="play"
        onClick={() => {
          const assertedWindow = window as any;
          // Trigger bridge message for IOS (What will be the equivalent for Android?)
          if (assertedWindow.webkit
              && assertedWindow.webkit.messageHandlers
              && assertedWindow.webkit.messageHandlers.gameSelected
          ) {
            assertedWindow.webkit.messageHandlers.gameSelected.postMessage({
              gameSelected: {
                name: game.name,
                icon: game.icon,
                description: game.description,
                theme: game.theme,
              },
            });
          }
        }}
      >
        <RightIcon fontSize="large" />
      </IconButton>
    </div>
  );
}
export default GameCell;
