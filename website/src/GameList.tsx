import React, { useState, useEffect } from 'react';
import Divider from '@material-ui/core/Divider';
import GameCell from './GameCell';

function GameList() {
  const [games, setGames] = useState<any>([]);
  useEffect(() => {
    fetch('https://kismet-bd1ac.firebaseio.com/assignment/games.json')
      .then((res) => res.json())
      .then((result) => {
        setGames(result.map((item: any, index: number) => ({ id: index, ...item })));
        const assertedWindow = window as any;
        if (assertedWindow.webkit
          && assertedWindow.webkit.messageHandlers
          && assertedWindow.webkit.messageHandlers.gamesLoaded) {
          assertedWindow.webkit.messageHandlers.gamesLoaded.postMessage({
            gamesLoaded: result.length,
          });
        }
      });
  }, []);
  return (
    <div>
      {games.map((game: any, i: number) => (
        <React.Fragment key={game.id}>
          <GameCell game={game} />
          {i < game.length - 1 && <Divider />}
        </React.Fragment>
      ))}
    </div>
  );
}
export default GameList;
