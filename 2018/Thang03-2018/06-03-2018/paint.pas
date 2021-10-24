const   ginp='paint.inp';
        gout='paint.out';
        df:array[1..9] of longint=(1,1,1,2,2,2,3,3,3);
        cf:array[1..9] of longint=(1,2,3,1,2,3,1,2,3);

var     gi,go:text;
        n,t:Longint;
        gc:array[0..25,1..3] of longint;
        f:array[1..9,0..25,0..25] of int64;

procedure qhd;
var     i,j,h,k,kc:Longint;
        min:int64;
begin
        for i:=1 to 9 do
                for j:=1 to n do
                        for k:=1 to n do
                        begin
                                f[i,j,k]:=maxlongint;
                                if k=j then
                                begin
                                        if gc[j,df[i]]<gc[j,cf[i]] then f[i,j,k]:=gc[j,df[i]]
                                        else f[i,j,k]:=gc[j,cf[i]];
                                end;
                                if k-j=1 then f[i,j,k]:=gc[j,df[i]]+gc[k,cf[i]];
                        end;
        for kc:=2 to n-1 do
                for i:=1 to n-kc do
                begin
                        j:=i+kc;
                        for h:=1 to 9 do
                        begin
                                min:=maxlongint;
                                for k:=1 to 9 do
                                        if (df[k]<>df[h]) and (cf[k]<>cf[h]) and (min>f[k,i+1,j-1]) then min:=f[k,i+1,j-1];
                                f[h,i,j]:=min+gc[i,df[h]]+gc[j,cf[h]];
                        end;
                end;
end;

procedure xuat;
var     i:longint;
        min:int64;
begin
        min:=maxlongint;
        for i:=1 to 9 do
                if f[i,1,n]<min then min:=f[i,1,n];
        writeln(go,min);
end;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,t);
end;

procedure process;
var     i,j,k:longint;
begin
        for k:=1 to t do
        begin
                readln(gi,n);
                for i:=1 to n do
                begin
                        for j:=1 to 3 do read(gi,gc[i,j]);
                        readln(gi);
                end;
                qhd;
                xuat;
        end;
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.