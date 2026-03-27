classdef AIFunctions

    properties
        apiKey = "YOUR_ENTERPRISE";
        model = "gpt-5.2"
    end

    methods
        
        function obj = AIFunctions(apiKey)
            obj.apiKey = apiKey;
        end

       
        % MAIN 

        function move = GetMove(obj, board, mode)

            aiBoard = obj.ConvertBoardToAI(board);

            if mode == "chatgpt"
                gptMove = obj.GetChatGPTMove(aiBoard);
                bestMove = obj.GetBestMove(aiBoard);

                % Only accept GPT if correct
                if gptMove == bestMove
                    move = gptMove;
                else
                    move = bestMove;
                end
            else
                move = obj.GetBestMove(aiBoard);
            end
            
            if move < 1 || move > 9 || board(move) ~= 0
                move = obj.GetRandomMove(board);
            end

        end

        % Board conversion
        % Grid: 0 empty, 2 = X, 3 = O
        % AI:   0 empty, 1 = X, 2 = O

        function aiBoard = ConvertBoardToAI(~, board)

            aiBoard = zeros(size(board));

            for i = 1:length(board)
                if board(i) == 2
                    aiBoard(i) = 1; % X
                elseif board(i) == 3
                    aiBoard(i) = 2; % O
                else
                    aiBoard(i) = 0;
                end
            end

        end

        % CHATGPT move

        function move = GetChatGPTMove(obj, board)

            try
                boardStr = sprintf('%d ', board);

                prompt = [
                    "You are an unbeatable Tic Tac Toe AI.\n" + ...
                    "Positions:\n1 2 3\n4 5 6\n7 8 9\n" + ...
                    "Board (0 empty, 1=X, 2=O): " + boardStr + "\n" + ...
                    "Return ONLY a number 1-9."
                ];

                response = openAIChat( ...
                    "apiKey", obj.apiKey, ...
                    "model", obj.model, ...
                    "messages", {struct("role","user","content",prompt)} ...
                );

                text = response.choices(1).message.content;

                move = str2double(regexp(text, '\d+', 'match', 'once'));

                if isnan(move)
                    move = -1;
                end

            catch
                move = -1;
            end

        end

        % MINIMAX (PERFECT AI)

        function bestMove = GetBestMove(obj, board)

            bestScore = -inf;
            bestMove = -1;

            for i = 1:9
                if board(i) == 0
                    board(i) = 2; % AI = O

                    score = obj.minimax(board, false);

                    board(i) = 0;

                    if score > bestScore
                        bestScore = score;
                        bestMove = i;
                    end
                end
            end

        end

        function score = minimax(obj, board, isMaximizing)

            result = obj.checkWinner(board);

            if result ~= 999
                score = result;
                return;
            end

            if isMaximizing
                bestScore = -inf;

                for i = 1:9
                    if board(i) == 0
                        board(i) = 2;
                        score = obj.minimax(board, false);
                        board(i) = 0;
                        bestScore = max(score, bestScore);
                    end
                end

                score = bestScore;

            else
                bestScore = inf;

                for i = 1:9
                    if board(i) == 0
                        board(i) = 1;
                        score = obj.minimax(board, true);
                        board(i) = 0;
                        bestScore = min(score, bestScore);
                    end
                end

                score = bestScore;
            end

        end

        % Winner check

        function result = checkWinner(~, board)

            wins = [
                1 2 3;
                4 5 6;
                7 8 9;
                1 4 7;
                2 5 8;
                3 6 9;
                1 5 9;
                3 5 7
            ];

            for i = 1:size(wins,1)
                a = wins(i,1);
                b = wins(i,2);
                c = wins(i,3);

                if board(a) ~= 0 && board(a) == board(b) && board(a) == board(c)
                    if board(a) == 2
                        result = 10;   % AI wins
                    else
                        result = -10;  % Player wins
                    end
                    return;
                end
            end

            if all(board ~= 0)
                result = 0;   % draw
            else
                result = 999; % ongoing
            end

        end

        %FALLBACK (SAFETY)
 
        function move = GetRandomMove(~, board)

            empty = find(board == 0);

            if isempty(empty)
                move = -1;
            else
                move = empty(randi(length(empty)));
            end

        end

    end
end