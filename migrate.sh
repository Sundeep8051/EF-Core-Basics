#!/bin/bash
dotnet ef migrations add "$1" --project data --startup-project api