const   ginp='ss.inp';
        gout='ss.out';
        maxn=15000;

var     gi,go:text;
        nheap:longint;
        h:array[0..maxn+100] of longint;

procedure swap(var x,y:longint);
var     tm:longint;
begin
        tm:=x;x:=y;y:=tm;
end;

procedure upheap(i:longint);
var     j:longint;
begin
        if i<=1 then exit;
        j:=i div 2;
        if h[i]>h[j] then
        begin
                swap(h[i],h[j]);
                upheap(j);
        end;
end;

procedure downheap(i:longint);
var     j:longint;
begin
        j:=i*2;
        if j>nheap then exit;
        if (h[j]<h[j+1]) and (j<nheap) then inc(j);
        if h[i]<h[j] then
        begin
                swap(h[i],h[j]);
                downheap(j);
        end;
end;

procedure push(x:longint);
begin
        inc(nheap);
        h[nheap]:=x;
        upheap(nheap);
end;

procedure pop;
begin
        swap(h[1],h[nheap]);
        dec(nheap);
        downheap(1);
end;

procedure sort(l,r:longint);
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=h[random(r-l+1)+l];
        repeat
                while h[i]<t do inc(i);
                while h[j]>t do dec(j);
                if i<=j then
                begin
                        swap(h[i],h[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure main;
var     i,x,k,n:longint;
        ou:array[0..maxn+100] of longint;
        s:string;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        nheap:=0;
        while not seekeof(gi) do
        begin
                readln(gi,s);
                if s[1]='+' then
                begin
                        k:=1;
                        val(copy(s,2,length(s)-1),x);
                end else k:=0;
                if (k=0) then
                begin
                        x:=h[1];
                        while (h[1]=x) and (nheap>0) do pop;
                end else
                if (k=1) and (nheap<maxn) then push(x);
        end;
        {while not seekeof(gi) do
        begin
            readln(gi,s);
            if s[1]='+' then
            begin
              if nheap<15000 then
                begin
                    tam:=copy(s,2,length(s));
                    val(tam,x,err);
                    add(x);
                end
                end
                ELSE
                if nheap>0 then
                begin
                        if nheap>0 then x:=pop;
                        while (nheap>0) and (h[1]=x) do pop;
                end;
        end;   }
        sort(1,nheap);
        n:=0;h[nheap+1]:=maxlongint;
        for i:=nheap downto 1 do
                if h[i]<>h[i+1] then
                begin
                        inc(n);
                        ou[n]:=h[i];
                end;
        writeln(go,n);
        for i:=1 to n do writeln(go,ou[i]);
        close(gi);close(go);
end;

begin
        main;
end.
