const   fi='NZERO.INP';
        fo='NZERO.OUT';
        mxn=1000009;
        mu:array[0..3] of integer=(6,2,4,8);
var     dem,kq:array[1..1000009] of longint;
        c:array[1..1000009] of boolean;
        g:text;
procedure enter;
var i,n:longint;
begin
        assign(g,fi);  assign(output,fo);rewrite(output);
        reset(g);
        repeat
                readln(g,n);
                if n=0 then break;
                writeln(kq[n]);
        until false;
        close(g);  close(output);
end;

procedure khoitao;
var i:longint;
        j:int64;
begin
        fillchar(c,sizeof(c),true);
        fillchar(dem,sizeof(dem),0);
        c[1]:=false;i:=2;
        while i<=trunc(sqrt(mxn)) do
        begin
                while not c[i] do inc(i);
                dem[i]:=i;
                j:=i*i;
                while j<=mxn do
                begin
                        c[j]:=false;
                        j:=j+i;
                end;
                j:=i*i;
                while j<=mxn do
                begin
                        dem[j]:=i;
                        j:=j*i;
                end;
                inc(i);
        end;
        for i:=trunc(sqrt(mxn))+1 to mxn do if c[i]  then dem[i]:=i;

end;

procedure main;
var i,j,d2,d5,tmp:longint;
begin
        d2:=0;d5:=0;  tmp:=1;     kq[1]:=1;
        for i:=2 to mxn do
        begin
                if dem[i]=0 then kq[i]:=kq[i-1]
                else
                begin
                        if dem[i]=2 then inc(d2) else if dem[i]=5 then inc(d5)
                        else tmp:=(tmp*dem[i]) mod 10;
                        if (d2>d5) then
                        kq[i]:=(tmp*(mu[(d2-d5) mod 4])) mod 10 else kq[i]:=tmp mod 10;
                end;
        end;
end;

begin
        khoitao;
        main;
        enter ;
end.
