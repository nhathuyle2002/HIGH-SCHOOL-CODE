const   ginp='rect.inp';
        gout='rect.out';
        oo=trunc(1e9);

type    tdv=record g,v:longint;end;

var     gi,go:text;
        n,coux,couy:longint;
        x1,y1,x2,y2:array[0..1010] of tdv;
        gx,gy:array[0..3010] of longint;
        f:array[0..3010,0..3010] of longint;
        res:int64;

procedure sort(l,r:longint;var d:array of tdv);
var     i,j:longint;
        t,tm:tdv;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=d[random(r-l+1)+l];
        repeat
                while d[i].g<t.g do inc(i);
                while d[j].g>t.g do dec(j);
                if i<=j then
                begin
                        tm:=d[i];d[i]:=d[j];d[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j,d);sort(i,r,d);
end;

procedure input;
var     i:longint;
        d:array[0..3010] of tdv;
begin
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,x1[i].g,y2[i].g,x2[i].g,y1[i].g);
                inc(x1[i].g);
        end;
        for i:=1 to n do
        begin
                d[i].g:=x1[i].g;d[i].v:=i;
                d[i+n].g:=x2[i].g;d[i+n].v:=i+n;
                d[i+2*n].g:=x1[i].g-1;d[i+2*n].v:=i+2*n;
        end;
        sort(1,3*n,d);
        coux:=0;d[0].g:=-oo;
        for i:=1 to 3*n do
        begin
                if d[i].g>d[i-1].g then
                begin
                        inc(coux);
                        gx[coux]:=d[i].g;
                end;
                if d[i].v<=n then x1[d[i].v].v:=coux else
                if d[i].v<=2*n then x2[d[i].v-n].v:=coux;
        end;
        for i:=1 to n do
        begin
                d[i].g:=y1[i].g;d[i].v:=i;
                d[i+n].g:=y2[i].g;d[i+n].v:=i+n;
        end;
        sort(1,2*n,d);
        couy:=0;
        for i:=1 to 2*n do
        begin
                if d[i].g>d[i-1].g then
                begin
                        inc(couy);
                        gy[couy]:=d[i].g;
                end;
                if d[i].v<=n then y1[d[i].v].v:=couy else
                y2[d[i].v-n].v:=couy;
        end;
end;

procedure process;
var     i,j,cou,i0:longint;
begin
        fillchar(f,sizeof(f),0);
        for i:=1 to n do
                for j:=x1[i].v to x2[i].v do
                begin
                        inc(f[y1[i].v,j],1);
                        inc(f[y2[i].v,j],-1);
                end;
        res:=0;
        for j:=1 to coux do
        begin
                cou:=0;
                for i:=1 to couy do
                begin
                        if (cou=0) and (f[i,j]>0) then i0:=i;
                        inc(cou,f[i,j]);
                        if (cou=0) and (f[i,j]<0) then
                                res:=res+int64(gx[j]-gx[j-1])*(gy[i]-gy[i0]);
                end;
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.


